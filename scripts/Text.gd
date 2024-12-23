extends Label

var width_max: int = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resized.connect(check_width)

func check_width():
	if (size.x >= width_max):
		autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		custom_minimum_size.x = width_max		
		resized.disconnect(check_width)
