extends Node2D

var spawn_dist = 500
var last_spawn = 500

func _physics_process(delta: float) -> void:
	if last_spawn >= spawn_dist:
		spawn_obstacle()
		print("!")
		last_spawn = 0
	else:
		print(last_spawn)
		if %Player.velocity.y < 0 and %Player.position.y <= %Player.upper_bound:
			last_spawn += abs(%Player.velocity.y * delta)

func spawn_obstacle():
	var obstacle = preload("res://Scenes/obstacle.tscn").instantiate()
	
	%SpawnPoint.progress_ratio = randf()
	
	obstacle.global_position = %SpawnPoint.global_position
	
	add_child(obstacle)
