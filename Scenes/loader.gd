extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var blood : PackedScene = preload("res://gpu_particles_2d.tscn")
	var splatter : GPUParticles2D = blood.instantiate()
	add_child(splatter)
	splatter.position = Vector2(900, 900)
	splatter.emitting = true
	var breathe : PackedScene = preload("res://Scenes/Breath.tscn")
	var breath : GPUParticles2D = blood.instantiate()
	add_child(breath)
	breath.position = Vector2(900, 900)
	breath.emitting = true
	var coughing : PackedScene = preload("res://Scenes/cough.tscn")
	var cough : GPUParticles2D = coughing.instantiate()
	add_child(cough)
	cough.position = Vector2(900, 900)
	cough.emitting = true
