extends Path2D

@onready var view = get_viewport_rect().size

#Keep spawn path outside of viewport
func _physics_process(_delta: float) -> void:
	position.y = %Player.position.y - view.y - 50
