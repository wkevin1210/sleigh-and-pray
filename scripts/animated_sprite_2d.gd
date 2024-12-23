extends AnimatedSprite2D

var moving = false
var shooting = false
var grappling = false
var end_game = false

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
	
	if Input.is_action_pressed("shoot") and end_game:
		shooting = true
		play("Attack")
	if Input.is_action_just_released("shoot"):
		shooting = false
