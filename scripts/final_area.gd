extends Node2D

signal dialogue

@export var player : CharacterBody2D
@export var Rudolph : AnimatedSprite2D
@export var breathing : GPUParticles2D
@onready var breathe : PackedScene = preload("res://Scenes/Breath.tscn")
@onready var cough : PackedScene = preload("res://Scenes/cough.tscn")
@onready var BreathPos : Node2D = get_node("Rudolph/AnimatedSprite2D/BreathPos")
@onready var talk_canvas : CanvasLayer = $"%Final Talk"
@onready var talk : AnimationPlayer = get_node("Final Talk/MainAnimator")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var transition : AnimationPlayer = get_node("TransitionScreen/AnimationPlayer")
	transition.play("Fade_From_White")
	await transition.animation_finished
	talk.play("End_game_Enter")
	talk_canvas.visible = true

func _on_fall_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Rudolph.play("Fall")
	

func _on_dialogue_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Rudolph.play("Arm_Down_Breathing")
		talk_canvas.visible = true
		talk.play("End_game")
		emit_signal("dialogue")
		


func _on_animated_sprite_2d_animation_looped() -> void:
	var breath : GPUParticles2D = breathe.instantiate()
	add_child(breath)
	breath.global_position = BreathPos.global_position
	breath.emitting = true


func _on_main_animator_animation_finished(anim_name: StringName) -> void:
	talk_canvas.visible = false

func _cough():
	var coughing : GPUParticles2D = cough.instantiate()
	add_child(coughing)
	coughing.global_position = BreathPos.global_position
	coughing.emitting = true
