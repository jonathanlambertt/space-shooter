extends Node

var hit_sound = preload("res://assets/hit_thud.wav")
var hit_volume: float = -25.0

func play_hit():
	var p = AudioStreamPlayer.new()
	p.stream = hit_sound
	p.volume_db = hit_volume
	add_child(p)
	p.play()
	p.finished.connect(p.queue_free)
