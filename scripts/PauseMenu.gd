extends CanvasLayer

@onready var options_menu = get_node("OptionsMenu")
@onready var pause_container = get_node("MainContainer")

func _ready():
	get_tree().paused = true

func _on_continue_pressed():
	$AnimationPlayer.play("on_close")
	get_tree().paused = false
	

func _on_option_pressed():
	options_menu.show()
	pause_container.hide()

func _on_exit_pressed():
	$AnimationPlayer.play("on_close")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func on_close_panel():
	get_tree().paused = false
	queue_free()
