extends CanvasLayer

var is_full_screen = false

@onready var window_mode_button = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/WindowModeButton")
@onready var music_control_volume = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MusicContainer/MusicControl")
@onready var sfx_control_volume = get_node("MarginContainer/PanelContainer/MarginContainer/VBoxContainer/SFXContainer/SFXControl")

func _ready():
	music_control_volume.connect("on_volume_change", _on_music_volume_changed, CONNECT_DEFERRED)
	sfx_control_volume.connect("on_volume_change", _on_sfx_volume_changed, CONNECT_DEFERRED)

func on_enable():
	$AnimationPlayer.play("on_open")
	pass

func _on_window_mode_pressed():
	is_full_screen = !is_full_screen
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_full_screen else DisplayServer.WINDOW_MODE_WINDOWED)
	window_mode_button.text = ("Fullscreen" if is_full_screen else "Windowed").to_upper()


func _on_back_button_pressed():
	$AnimationPlayer.play("on_close")
	get_parent().get_node("MainContainer").show()
	get_parent().get_node("AnimationPlayer").play("on_open")

func _on_music_volume_changed(value):
	print("Music volume changed to: ", value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sfx_volume_changed(value):
	print("SFX volume changed to: ", value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
