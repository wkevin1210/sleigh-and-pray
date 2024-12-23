extends Sprite2D

const HOOK_DURATION = 0.1
const MAX_TIME = 0.15
@onready var ray_cast: RayCast2D = $RayCast2D
var max_dist = 150.0
var distance = 100.0

signal hooked(hooked_position)

func interpolate(length, duration):
	var tween_offset = get_tree().create_tween()
	var tween_rect_h = get_tree().create_tween()
	
	tween_offset.tween_property(self, "offset", Vector2(0, length/2.0), duration)
	tween_rect_h.tween_property(self, "region_rect", Rect2(0,0,8, length), duration)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("grapple"):
		ray_cast.force_raycast_update()
		distance = await check_collision()
		var hook_time = MAX_TIME * distance/max_dist
		interpolate(distance, hook_time)
		await get_tree().create_timer(hook_time).timeout
		reverse_interpolate(hook_time)
		
func reverse_interpolate(time):
	interpolate(0,time - 0.1)

func check_collision():
	var collision_point: Vector2
	if ray_cast.is_colliding():
		collision_point = ray_cast.get_collision_point()
		distance = global_position.distance_to(collision_point) * 0.55
		hooked.emit(collision_point)
	else:
		distance = max_dist
	return distance
