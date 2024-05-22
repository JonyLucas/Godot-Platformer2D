extends HBoxContainer

var current_volume: float = 1.0

signal on_volume_change

func _ready():
	$MinusButton.button_down.connect(_change_volume.bind(-0.1))
	$PlusButton.button_down.connect(_change_volume.bind(0.1))

func _change_volume(change: float):
	current_volume = clamp(current_volume + change, 0.0, 1.0)
	$Label.text = str(current_volume * 10)
	$AudioStreamPlayer.play()
	emit_signal("on_volume_change", current_volume)
