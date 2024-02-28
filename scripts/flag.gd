extends Node

signal win_condition

func _on_area_entered(_body:Node2D):
	print("win")
	emit_signal("win_condition")
