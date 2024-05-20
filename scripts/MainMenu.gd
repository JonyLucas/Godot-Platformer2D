extends CanvasLayer

func _on_play_button_pressed():
	$TransitionTimer.start()
	$TransitionLayer.visible = true
	$TransitionLayer/AnimationPlayer.play("start_transition")

func _on_option_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()


func _on_transition_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
