extends CanvasLayer

func _ready():
	$PanelContainer/MarginContainer/VBoxContainer/Button.connect("pressed", on_next_button_pressed)

func on_next_button_pressed():
	$"/root/Main/LevelLoader".load_next_level()
