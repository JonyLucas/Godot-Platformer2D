extends CanvasLayer

func _ready():
	get_tree().paused = true

func _on_continue_pressed():
	get_tree().paused = false
	queue_free()

func _on_option_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")