extends Node

var hit_sound = preload("res://assets/hit_thud.wav")

func play_hit():
	var p = AudioStreamPlayer.new()
	p.stream = hit_sound
	add_child(p)
	p.play()
	p.finished.connect(p.queue_free)
