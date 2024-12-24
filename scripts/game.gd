extends Node2D

var obs_spawn_dist = 500
var obs_last_spawn = 500

var enemy_spawn_dist = 800
var enemy_last_spawn = 0
var enemy_spawn_count = 2

<<<<<<< Updated upstream
=======
var game_over = false

func _ready() -> void:
	$CutSceneTimer.wait_time = $Control/MainAnimator.current_animation_length - 1
	get_tree().paused = true
	%Wind.play()
	

>>>>>>> Stashed changes
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
	%SpawnPoint.progress_ratio = randf()
	
	enemy.global_position = %SpawnPoint.global_position
	
	add_child(enemy)
<<<<<<< Updated upstream
=======


func _on_child_exiting_tree(node: Node) -> void:
	if node.is_in_group("Boss"):
		transitioner.global_position.y = (%Player.global_position.y - 2000)

		%Music.stream_paused = true
		game_over = true

func _on_boss_boss_hit() -> void:
	obs_spawn_dist -= 5
	
	if $Boss.HP <= 4:
		if enemy_spawn_count < 4:
			enemy_spawn_count += 1


func _on_music_finished() -> void:
	%Music.play()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and game_over:
		print("crossed")
		%TransitionScreen.transition()
		

func _on_transition_screen_transitioned() -> void:
	get_tree().change_scene_to_packed(end_game)


func _on_cut_scene_timer_timeout() -> void:
	print("!")
	%Music.play()
	%Wind.stop()
	get_tree().paused = false


func _on_wind_finished() -> void:
	%Wind.play()
>>>>>>> Stashed changes
