extends CanvasLayer

@onready var options_menu = get_node("OptionsMenu")
@onready var pause_container = get_node("MainContainer")

var is_option_pressed = false

func _ready():
	get_tree().paused = true

func _on_continue_pressed():
	$AnimationPlayer.play("on_close")
	get_tree().paused = false
	

func _on_option_pressed():
	is_option_pressed = true
	$AnimationPlayer.play("on_close")
	options_menu.show()
	options_menu.on_enable()

func _on_exit_pressed():
	$AnimationPlayer.play("on_close")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func on_close_panel():
	if is_option_pressed:
		return
	
	get_tree().paused = false
	queue_free()
