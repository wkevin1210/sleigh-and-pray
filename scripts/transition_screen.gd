extends CanvasLayer

signal transitioned

func transition():
	print("transitioning")
	$AnimationPlayer.play("Fade_to_White")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade_to_White":
		emit_signal("transitioned")
		$AnimationPlayer.play("Fade_From_White")
		if %DiaglogueTrigger != null:
			%DialogueTrigger.monitoring = false
