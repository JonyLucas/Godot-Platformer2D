extends CanvasLayer

@onready var options_menu = get_node("OptionsMenu")
@onready var pause_container = get_node("MainContainer")

var is_option_pressed = false

func _on_play_button_pressed():
	$TransitionTimer.start()
	$TransitionLayer.visible = true
	$TransitionLayer/AnimationPlayer.play("start_transition")

func _on_option_button_pressed():
	is_option_pressed = true
	$AnimationPlayer.play("on_close")
	options_menu.show()
	options_menu.on_enable()

func _on_exit_button_pressed():
	get_tree().quit()

func _on_transition_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
