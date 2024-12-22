extends CharacterBody2D

#Shooting vars
var shoot_timer = 0.3
var fire_rate = 0.3

#Define vars for camera movement
@onready var view = get_viewport_rect().size
@onready var lower_bound = view.y
@onready var upper_bound = int(lower_bound * ((1.0 -
												$Camera.drag_top_margin)/ 2.0))

#Vars for sliding
const MAXSPEED = 400
const ACCEL = 300
const DECEL = 300

#Vars for hook
var hook_direction
var look_position
var hooking = false
var speed_added = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	#Handle one-way camera
	if position.y < upper_bound:
		lower_bound -= upper_bound - position.y
		upper_bound = position.y
		
	if not hooking:
		look_position = get_global_mouse_position()
	look_at(look_position)
	
	#Handle sliding movement
	if hooking and not speed_added:
		velocity += hook_direction * MAXSPEED
		speed_added = true
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAXSPEED, ACCEL * delta)
	else:
		if position.y == lower_bound:
		#Allow player to instantly accelerate if at border
			velocity = Vector2.ZERO
		else:
			velocity = velocity.move_toward(Vector2.ZERO, DECEL * delta)
	move_and_slide()
	
	#Prevent player from moving backwards
	if position.y > lower_bound:
		position.y = lower_bound
	
	#Prevent max fire rate or faster fire rate when clicking individually
	shoot_timer -= delta
	if Input.is_action_pressed("shoot"):
		if shoot_timer <= 0:
			shoot()
			shoot_timer = fire_rate

@export var damage = 10

func shoot():
	const BULLET = preload("res://Scenes/bullet.tscn")
	
	#Spawns bullet with correct roataion and position at shootingpoint
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func _on_hook_hooked(hooked_position: Variant) -> void:
	
	await get_tree().create_timer($Hook.HOOK_DURATION).timeout
	var distance = global_position.distance_to(hooked_position)
	var hook_time = $Hook.MAX_TIME * distance/$Hook.max_dist
	hooking = true
	hook_direction = global_position.direction_to(hooked_position)
	look_position = hooked_position
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	await get_tree().create_timer(hook_time + 0.1).timeout
	hooking = false
	speed_added = false
	
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
