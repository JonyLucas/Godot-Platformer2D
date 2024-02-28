extends Node

signal win_condition

func _on_area_entered(_body:Node2D):
	emit_signal("win_condition")
