extends Button

@export var disable_hover_animation: bool = false

func _ready():
	pivot_offset = size / 2

func _on_mouse_entered():
	if disable_hover_animation:
		return

	$AnimationPlayer.play("hover")
	pivot_offset = size / 2


func _on_mouse_exited():
	if disable_hover_animation:
		return

	$AnimationPlayer.play_backwards("hover")
	pivot_offset = size / 2
	rotation = 0


func _on_pressed():
	$Audio/AudioStreamPlayer.play()
	$AnimationPlayer.play("click")
