extends CanvasLayer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta):
	$Sprite2D.position = get_tree().get_root().get_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$AnimationPlayer.clear_queue()
		$AnimationPlayer.play("click")