extends HBoxContainer

var current_volume: float = 1.0

signal on_volume_change

func _ready():
	$MinusButton.button_down.connect(change_volume.bind(-0.1))
	$PlusButton.button_down.connect(change_volume.bind(0.1))

func change_volume(change: float):
	current_volume = clamp(current_volume + change, 0.0, 1.0)
	$Label.text = str(round(current_volume * 10))
	emit_signal("on_volume_change", current_volume)
