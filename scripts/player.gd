extends CharacterBody2D

# Movement tuning
@export var speed: float = 150.0
@export var acceleration: float = 600.0
@export var deceleration: float = 500.0

# Combat tuning
@export var fire_rate: float = 0.2

# Screen boundaries (384x216 viewport with buffer)
var margin: float = 12.0
var min_x: float = 0.0
var max_x: float = 384.0
var min_y: float = 0.0
var max_y: float = 216.0

# Timers
var fire_timer: float = 0.0
var hurt_timer: float = 0.0
var hurt_duration: float = 0.15

# Node references
@onready var ship_sprite: AnimatedSprite2D = $ShipSprite
@onready var hitbox: Area2D = $HitBox
var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

func _ready() -> void:
	hitbox.area_entered.connect(_on_hit)

func _physics_process(delta: float) -> void:
	# Reset hurt tint when timer expires
	if hurt_timer > 0:
		hurt_timer -= delta
		if hurt_timer <= 0:
			ship_sprite.modulate = Color(1, 1, 1)
	
	# Get input direction from WASD / arrow keys
	var input_dir := Vector2.ZERO
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir.y = Input.get_axis("ui_up", "ui_down")
	
	# Accelerate toward target velocity, decelerate when no input
	var target_velocity := input_dir * speed
	
	if input_dir.x != 0:
		velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)
	
	if input_dir.y != 0:
		velocity.y = move_toward(velocity.y, target_velocity.y, acceleration * delta)
	else:
		velocity.y = move_toward(velocity.y, 0.0, deceleration * delta)
	
	move_and_slide()
	
	# Keep the player within viewport bounds
	position.x = clamp(position.x, min_x + margin, max_x - margin)
	position.y = clamp(position.y, min_y + margin, max_y - margin)
	
	# Fire bullets on cooldown while spacebar is held
	fire_timer -= delta
	if Input.is_action_pressed("shoot") and fire_timer <= 0:
		shoot()
		fire_timer = fire_rate
	
	update_animation()

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	# Spawn bullet just above the ship's nose
	bullet.position = Vector2(position.x, position.y - 12)
	get_parent().add_child(bullet)

func update_animation() -> void:
	if Input.is_action_pressed("ui_left"):
		ship_sprite.play("lean_left")
	elif Input.is_action_pressed("ui_right"):
		ship_sprite.play("lean_right")
	else:
		ship_sprite.play("idle")

func _on_hit(area: Area2D) -> void:
	# Flash the ship red briefly to indicate damage
	ship_sprite.modulate = Color(1, 0.3, 0.3)
	hurt_timer = hurt_duration
	Sfx.play_hit()
