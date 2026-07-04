extends Area2D

var speed: float = 300.0

func _physics_process(delta: float) -> void:
	position.y -= speed * delta
	
	# Remove when off screen
	if position.y < -20:
		queue_free()
