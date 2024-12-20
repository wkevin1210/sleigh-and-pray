extends CharacterBody2D

#Shooting vars
var shoot_timer = 1.0
var fire_rate = 1.0

#Define vars for camera movement
@onready var view = get_viewport_rect().size
@onready var lower_bound = view.y
@onready var upper_bound = int(lower_bound * ((1.0 -
												$Camera.drag_top_margin)/ 2.0))

#Vars for sliding
const MAXSPEED = 400
const ACCEL = 300
const DECEL = 300

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	#Handle one-way camera
	if position.y < upper_bound:
		lower_bound -= upper_bound - position.y
		upper_bound = position.y
	
	#Handle sliding movement
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
	print(lower_bound)

	look_at(get_global_mouse_position())

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
	new_bullet.damage = damage
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
