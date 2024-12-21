extends Area2D

@onready var sprite : Sprite2D = $Snowball

var travelled = 0

func _physics_process(delta: float) -> void:
	const SPEED = 700
	const RANGE = 1200
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled += SPEED * delta
	
	if travelled == RANGE:
		queue_free()
	
	sprite.rotation_degrees -= 4
func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
