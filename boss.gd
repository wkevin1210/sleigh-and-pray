extends CharacterBody2D

@onready var player : CharacterBody2D = get_node("/root/Game/Player")
@onready var distance_to_player = position.y - player.position.y
var move_speed : float = 100.0
var slow_speed : float = 50.0
var HP = 10
var just_hit = false
var target_x = 0

func _process(delta: float) -> void:
#	if position.x < target_x:
#		velocity.x += 100
#	elif  po
	distance_to_player = -(position.y - player.position.y)
	if distance_to_player < 400:
		velocity.y -= move_speed * delta
	elif distance_to_player > 400:
		if velocity.y < -200:
			velocity.y += slow_speed * delta
	elif distance_to_player < -1000:
		velocity.y = -100
	move_and_slide()
	

func take_damage():
	if distance_to_player < 600:
		if HP > 0 and not just_hit:
			just_hit = true
			HP -= 1
			print(HP)
			velocity.y = -400
			visible = false
			await get_tree().create_timer(.1).timeout
			visible = true
			await get_tree().create_timer(.1).timeout
			visible = false
			await get_tree().create_timer(.1).timeout
			visible = true
			await get_tree().create_timer(.5).timeout
			just_hit = false
		elif HP <= 0:
			queue_free()


func _on_timer_timeout() -> void:
	target_x = randi_range(135, 1000)
