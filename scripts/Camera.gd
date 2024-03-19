extends Camera2D

@export var background_color = Color(0.5, 0.5, 0.5)
@export var shake_noise: Noise
@export var max_shake_offset: float = 4
@export var noise_sample_step: float = 0.1

var x_noise_line = Vector2.RIGHT
var y_noise_line = Vector2.DOWN
var x_noise_position = Vector2.ZERO
var y_noise_position = Vector2.ZERO
var current_shake_percentage = 0
var shake_decay = 6

func _ready():
	RenderingServer.set_default_clear_color(background_color)

func _process(delta):
	if current_shake_percentage > 0:
		x_noise_position += x_noise_line * noise_sample_step * delta
		y_noise_position += y_noise_line * noise_sample_step * delta
		var x_noise = shake_noise.get_noise_2d(x_noise_position.x, x_noise_position.y)
		var y_noise = shake_noise.get_noise_2d(y_noise_position.x, y_noise_position.y)

		offset = Vector2(x_noise, y_noise) * max_shake_offset * pow(current_shake_percentage, 2)
		current_shake_percentage = max(0, current_shake_percentage - shake_decay * delta)
		

func apply_shake(percentage: float):
	current_shake_percentage = clamp(percentage + current_shake_percentage, 0, 1) # add the shake gives more impactfull effect


