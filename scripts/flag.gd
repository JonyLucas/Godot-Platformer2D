extends Node

signal win_condition

func _on_area_entered(_body:Node2D):
	$ConfettiParticles.emitting = true
	$Audio/Audio/AudioStreamPlayer.play()
	emit_signal("win_condition")
