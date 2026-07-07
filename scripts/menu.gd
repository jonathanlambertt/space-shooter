extends Control

@onready var play_button: TextureButton = $TextureButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	play_button.mouse_entered.connect(_on_hover)
	play_button.mouse_exited.connect(_on_unhover)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_hover() -> void:
	play_button.modulate = Color(1.3, 1.3, 1.3)

func _on_unhover() -> void:
	play_button.modulate = Color(1, 1, 1)
