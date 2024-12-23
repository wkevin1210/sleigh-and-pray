extends Node2D

@export var player : CharacterBody2D
@export var Rudolph : AnimatedSprite2D
@export var breathing : GPUParticles2D
@onready var breathe : PackedScene = preload("res://Scenes/Breath.tscn")
@onready var BreathPos : Node2D = get_node("Rudolph/AnimatedSprite2D/BreathPos")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var transition : AnimationPlayer = get_node("TransitionScreen/AnimationPlayer")
	transition.play("Fade_From_White")

func _on_fall_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Rudolph.play("Fall")
	

func _on_dialogue_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Rudolph.play("Arm_Down_Breathing")
		


func _on_animated_sprite_2d_animation_looped() -> void:
	var breath : GPUParticles2D = breathe.instantiate()
	add_child(breath)
	breath.global_position = BreathPos.global_position
	breath.emitting = true
