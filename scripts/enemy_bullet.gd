extends Area2D

var speed: float = 130.0

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > 240:
		queue_free()
