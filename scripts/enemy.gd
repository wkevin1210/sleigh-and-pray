extends CharacterBody2D

@onready var player: CharacterBody2D = get_node("/root/Game/Player")
@onready var animator: AnimatedSprite2D = get_node('AnimatedSprite2D')
@onready var bouncer: CollisionShape2D = get_node("BounceBox/CollisionShape2D")
@onready var collider: CollisionShape2D = get_node("CollisionShape2D")
@onready var snow_splash: GPUParticles2D = get_node("GPUParticles2D")
var alive = true

#Movement code
var move_speed = 300
func _physics_process(_delta: float) -> void:
	if alive:
		var direction = global_position.direction_to(player.global_position)
		look_at(player.position)
		velocity = direction * move_speed
	if not alive: 
		velocity = Vector2(0,0)
		collider.disabled = true
		bouncer.disabled = true
	move_and_slide()
	if position.y > player.lower_bound + 100:
		#Despawn enemy
		queue_free()
	

#Take damage
var health = 1
func take_damage():
	snow_splash.emitting = true
	health -= 1
	if health == 0:
		alive = false
		$AudioStreamPlayer2D.play()
		animator.play("Death")
		

#Collision code
var push_strength = 325
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
