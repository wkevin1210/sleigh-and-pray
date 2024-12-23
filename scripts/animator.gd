extends AnimatedSprite2D

var moving = false
var shooting = false
var grappling = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"):
		moving = true
	else:
		moving = false
	
	if moving and not shooting and not grappling: 
		play("Walk")
	elif not moving and not shooting and not grappling:
		play("Idle")
	
	if Input.is_action_pressed("shoot"):
		shooting = true
		play("Attack")
	if Input.is_action_just_released("shoot"):
		shooting = false
		
	if Input.is_action_just_pressed("grapple"):
		grappling = true
		play("Grapple Throw")
	if Input.is_action_just_released("grapple"):
		grappling = false
