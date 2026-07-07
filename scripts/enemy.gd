extends Area2D

@export var strafe_speed: float = 60.0
@export var strafe_distance: float = 80.0
@export var min_fire_delay: float = 1.0
@export var max_fire_delay: float = 3.0

var start_x: float = 0.0
var direction: float = 1.0
var fire_timer: float = 0.0
var hurt_timer: float = 0.0
var hurt_duration: float = 0.15

var enemy_bullet_scene: PackedScene = preload("res://scenes/enemy_bullet.tscn")
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	start_x = position.x
	fire_timer = randf_range(min_fire_delay, max_fire_delay)

func _physics_process(delta: float) -> void:
	# Reset hurt tint when timer expires
	if hurt_timer > 0:
		hurt_timer -= delta
		if hurt_timer <= 0:
			sprite.modulate = Color(1, 1, 1)

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
	# Flash the ship red briefly to indicate damage
	sprite.modulate = Color(1, 0.3, 0.3)
	hurt_timer = hurt_duration
