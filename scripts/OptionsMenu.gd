extends CanvasLayer

var is_full_screen = false

@onready var window_mode_button = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/WindowModeButton")

func _on_window_mode_pressed():
	is_full_screen = !is_full_screen
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_full_screen else DisplayServer.WINDOW_MODE_WINDOWED)
	window_mode_button.text = ("Fullscreen" if is_full_screen else "Windowed").to_upper()


func _on_back_button_pressed():
	get_parent().get_node("MainContainer").show()
	hide()
