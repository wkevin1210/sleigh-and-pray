extends Area2D

@onready var player: CharacterBody2D = get_node("/root/Game/Player")

#Collision code
var push_strength = 300
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var push_direction = (body.global_position - global_position).normalized()
		body.velocity = push_direction * push_strength

#Movement code
var move_speed = 0.07
func _physics_process(_delta: float) -> void:
	position.x = lerp(position.x, player.position.x, move_speed)
	position.y = lerp(position.y, player.position.y, move_speed)
	#Decay move_speedw
	move_speed *= 0.999
	if position.y > player.lower_bound and move_speed <= 0.01:
		#Despawn enemy
		queue_free()

#Take damage
var health = 3
func take_damage():
	health -= 1
	if health == 0:
		queue_free()
