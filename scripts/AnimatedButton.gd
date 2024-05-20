extends Button


func _on_mouse_entered():
	$AnimationPlayer.play("hover")
	pivot_offset = size / 2


func _on_mouse_exited():
	$AnimationPlayer.play_backwards("hover")
	pivot_offset = size / 2
	rotation = 0


func _on_pressed():
	$AnimationPlayer.play("click")
