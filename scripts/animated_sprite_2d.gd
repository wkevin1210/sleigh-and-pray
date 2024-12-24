extends AnimatedSprite2D

var moving = false
var shooting = false
var grappling = false
var end_game = false
var paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"):
		moving = true
	else:
		moving = false
	
	if moving and not shooting and not grappling and not paused: 
		play("Walk")
	elif not moving and not shooting and not grappling:
		play("Idle")
	
	if Input.is_action_pressed("shoot") and end_game:
		shooting = true
		play("Attack")
	if Input.is_action_just_released("shoot"):
		shooting = false


func _on_final_area_dialogue() -> void:
	paused = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "End_game":
		paused = false


func _on_main_animator_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
