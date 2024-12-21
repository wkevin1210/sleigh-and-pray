extends Node2D

var obs_spawn_dist = 500
var obs_last_spawn = 500

var enemy_spawn_dist = 800
var enemy_last_spawn = 0
var enemy_spawn_count = 2

func _physics_process(delta: float) -> void:
	if obs_last_spawn >= obs_spawn_dist:
		spawn_obstacle()
		obs_last_spawn = 0
	else:
		if %Player.velocity.y < 0 and %Player.position.y <= %Player.upper_bound:
			#Spawn only if player is moving the viewport forwards
			obs_last_spawn += abs(%Player.velocity.y * delta)
			
	if enemy_last_spawn >= enemy_spawn_dist:
		for enemy_spawn in range(enemy_spawn_count):
			spawn_enemy()
			enemy_last_spawn = 0
	else:
		if %Player.velocity.y < 0 and %Player.position.y <= %Player.upper_bound:
			enemy_last_spawn += abs(%Player.velocity.y * delta)

func spawn_obstacle():
	var obstacle = preload("res://Scenes/obstacle.tscn").instantiate()
	
	%SpawnPoint.progress_ratio = randf()
	
	obstacle.global_position = %SpawnPoint.global_position
	
	add_child(obstacle)
	
func spawn_enemy():
	var enemy = preload("res://Scenes/enemy.tscn").instantiate()
	print("!")
	%SpawnPoint.progress_ratio = randf()
	
	enemy.global_position = %SpawnPoint.global_position
	
	add_child(enemy)
