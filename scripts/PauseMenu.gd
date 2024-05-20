extends CanvasLayer

func _ready():
	get_tree().paused = true

func _on_continue_pressed():
	$AnimationPlayer.play("on_close")
	get_tree().paused = false
	

func _on_option_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	$AnimationPlayer.play("on_close")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func on_close_panel():
	get_tree().paused = false
	queue_free()