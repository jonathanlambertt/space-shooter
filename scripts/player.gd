extends CharacterBody2D

@export var speed: float = 150.0
@export var acceleration: float = 600.0
@export var deceleration: float = 500.0

# Screen boundaries (based on 384x216 viewport)
var margin: float = 12.0
var min_x: float = 0.0
var max_x: float = 384.0
var min_y: float = 0.0
var max_y: float = 216.0

@onready var ship_sprite: Sprite2D = $ShipSprite

# Change these to match whichever frames are correct on your sheet
@export var frame_idle: int = 18
@export var frame_lean_left: int = 16
@export var frame_lean_right: int = 20

func _physics_process(delta: float) -> void:
	# Get input
	var input_dir := Vector2.ZERO
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir.y = Input.get_axis("ui_up", "ui_down")
	
	# Smooth acceleration and deceleration
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
	
	# Clamp to screen
	position.x = clamp(position.x, min_x + margin, max_x - margin)
	position.y = clamp(position.y, min_y + margin, max_y - margin)
	
	# Animation handling
	update_animation()

func update_animation() -> void:
	if Input.is_action_pressed("ui_left"):
		ship_sprite.frame = frame_lean_left
	elif Input.is_action_pressed("ui_right"):
		ship_sprite.frame = frame_lean_right
	else:
		ship_sprite.frame = frame_idle
