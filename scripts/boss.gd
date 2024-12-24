extends CharacterBody2D

@onready var player : CharacterBody2D = get_node("/root/Game/Player")
@onready var distance_to_player = global_position.distance_to(player.global_position)
@onready var dist_label : Label = get_node("CanvasLayer/Right Text/MarginContainer/DistText")
var animations = ["Fight8", "Fight7", "Fight6", "Fight5", "Fight4", "Fight3", "Fight2", "Fight1"]
var move_speed : float = 100.0
var slow_speed : float = 50.0
var HP = 7
var just_hit = false
var target_x = 0
signal boss_hit



func _ready() -> void:
	var distance_to_player = global_position.distance_to(player.global_position)
	velocity.y = -400

func _process(delta: float) -> void:
	if position.x < target_x:
		velocity.x += 10 * delta
	elif  position.x > target_x:
		velocity.x -= 10 * delta
	elif position.x == target_x:
		velocity.x = 0
	distance_to_player = global_position.distance_to(player.global_position)
	dist_label.text = str("Distance: ", roundi(distance_to_player))
	if distance_to_player < 400:
		velocity.y -= move_speed * delta
	elif distance_to_player > 400:
		if velocity.y < -200:
			velocity.y += slow_speed * delta
	elif distance_to_player < -1000:
		velocity.y = -100
	move_and_slide()
	

func take_damage():
	boss_hit.emit()
	if distance_to_player < 600:
		if HP > 0 and not just_hit:	
			%MainAnimator.play(animations[HP])
			just_hit = true
			HP -= 1
			$HitSound.play()
			velocity.y = -575
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
			%MainAnimator.play("Death")
			$BossDeathSound.play()
			velocity.y = -575
			await get_tree().create_timer(4).timeout
			queue_free()


func _on_timer_timeout() -> void:
	target_x = randi_range(300, 800)
