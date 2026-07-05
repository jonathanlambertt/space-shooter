extends Area2D

@export var strafe_speed: float = 60.0
@export var strafe_distance: float = 80.0
@export var min_fire_delay: float = 1.0
@export var max_fire_delay: float = 3.0

var start_x: float = 0.0
var direction: float = 1.0
var fire_timer: float = 0.0

var enemy_bullet_scene: PackedScene = preload("res://scenes/enemy_bullet.tscn")

func _ready() -> void:
	start_x = position.x
	fire_timer = randf_range(min_fire_delay, max_fire_delay)

func _physics_process(delta: float) -> void:
	# Strafe left and right
	position.x += strafe_speed * direction * delta
	
	if position.x > start_x + strafe_distance:
		direction = -1.0
	elif position.x < start_x - strafe_distance:
		direction = 1.0
	
	# Shooting
	fire_timer -= delta
	if fire_timer <= 0:
		shoot()
		fire_timer = randf_range(min_fire_delay, max_fire_delay)
	
	if position.y > 240:
		queue_free()

func shoot() -> void:
	var bullet = enemy_bullet_scene.instantiate()
	bullet.position = Vector2(position.x, position.y + 12)
	get_parent().add_child(bullet)

func _on_area_entered(area: Area2D) -> void:
	print("enemy hit!")
