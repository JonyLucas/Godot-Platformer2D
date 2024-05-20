extends CanvasLayer

@export var coin_label: Label

func _ready():
	$PanelContainer/MarginContainer/VBoxContainer/NextButton.connect("pressed", on_next_button_pressed)
	$PanelContainer/MarginContainer/VBoxContainer/RestartButton.connect("pressed", on_restart_button_pressed)
	var level_manager = get_tree().get_first_node_in_group("level_manager")
	coin_label.text = str(level_manager.collected_coins) + " / " + str(level_manager.total_coins)

func on_next_button_pressed():
	$"/root/Main/LevelLoader".load_next_level()

func on_restart_button_pressed():
	$"/root/Main/LevelLoader".restart_level()
