extends CharacterBody2D

var move_speed = 200
var accel = 200
var shoot_timer = 0.3
var fire_rate = 0.3
var look_position
var end_game = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	shoot_timer -= delta
	if Input.is_action_pressed("shoot") and end_game:
		if shoot_timer <= 0:
			shoot()
			shoot_timer = fire_rate
			
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * move_speed, accel * delta)
	elif direction == Vector2.ZERO:
		velocity = Vector2(0,0)
		
	look_position = get_global_mouse_position()
	look_at(look_position)
	move_and_slide()

@export var damage = 10

func shoot():
	const BULLET = preload("res://Scenes/bullet.tscn")
	
	#Spawns bullet with correct roataion and position at shootingpoint
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
