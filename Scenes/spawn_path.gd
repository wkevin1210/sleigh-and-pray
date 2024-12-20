extends Path2D

@onready var view = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	position.y = %Player.position.y - view.y - 50
