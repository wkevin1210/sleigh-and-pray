extends Control

func _ready() -> void:
	$MenuSound.play()

func _on_start_pressed() -> void:
	$MenuClick.play()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_quit_pressed() -> void:
	$MenuClick.play()
	get_tree().quit()

var direction = Vector2(0,1)
var speed = 4

func _physics_process(_delta: float) -> void:
	$ParallaxBackground.scroll_offset += direction * speed


func _on_menu_sound_finished() -> void:
	$MenuSound.play()


func _on_credits_pressed() -> void:
	$MenuClick.play()
	$MainMenu.hide()
	$Title.hide()
	$Controls.hide()
	$CreditsText.show()
	$Back.show()
	
func _on_back_pressed() -> void:
	$MenuClick.play()
	$CreditsText.hide()
	$Controls.show()
	$Title.show()
	$Back.hide()
	$MainMenu.show()
