extends Area2D

@export var strafe_speed: float = 60.0
@export var strafe_distance: float = 80.0

var start_x: float = 0.0
var direction: float = 1.0

func _ready() -> void:
	start_x = position.x

func _physics_process(delta: float) -> void:
	# Strafe left and right
	position.x += strafe_speed * direction * delta
	
	# Reverse direction when reaching strafe limits
	if position.x > start_x + strafe_distance:
		direction = -1.0
	elif position.x < start_x - strafe_distance:
		direction = 1.0
	
	# Remove if somehow off screen
	if position.y > 240:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	pass
