extends Camera2D

@export var background_color = Color(0.5, 0.5, 0.5)

func _ready():
	RenderingServer.set_default_clear_color(background_color)
