extends CharacterBody2D

@onready var player: CharacterBody2D = get_node("/root/Game/Player")

#Movement code
var move_speed = 300
func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	look_at(player.position)
	velocity = direction * move_speed
	move_and_slide()
	if position.y > player.lower_bound + 100:
		#Despawn enemy
		queue_free()
	

#Take damage
var health = 3
func take_damage():
	health -= 1
	if health == 0:
		queue_free()

#Collision code
var push_strength = 300
var enemy_push = 0.1
func _on_bounce_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var push_direction = (body.global_position - global_position).normalized()
		body.velocity = push_direction * push_strength
		
	if body.is_in_group("Enemy"):
		var push_direction = (body.global_position - global_position).normalized()
		var target_position = body.global_position - push_direction
		
		position.x = lerp(position.x, target_position.x, enemy_push)
		position.y = lerp(position.y, target_position.y, enemy_push)
