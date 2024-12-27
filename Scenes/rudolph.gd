extends Node2D

@onready var blood : GPUParticles2D = get_node("Area2D/GPUParticles2D") 
@onready var Main_menu : PackedScene = preload("res://Scenes/menu.tscn")
@onready var rudolph : AnimatedSprite2D = get_node("AnimatedSprite2D")
var final = false
signal dead

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet") and not final:
		final = true
		%EnemyHit.playing = true
		blood.emitting = true
		rudolph.play("Die")
		emit_signal("dead")
		await get_tree().create_timer(4).timeout
		%TransitionScreen.transition()
	


func _on_transition_screen_transitioned() -> void:
	get_tree().change_scene_to_packed(Main_menu)
