extends CharacterBody2D

@export var max_speed = 200
@export var gravity = 500
@export var move_offset = 5
var direction = Vector2.RIGHT
var target_x_position = 0

func _ready():
	target_x_position = position.x + move_offset
	print(target_x_position)

func _process(delta):
	velocity.x = direction.x * max_speed * delta
	velocity.y += gravity * delta
	move_and_slide()

	if position.x >= target_x_position and direction.x > 0:
		direction = -direction
		target_x_position = position.x - move_offset
	elif position.x <= target_x_position and direction.x < 0:
		direction = -direction
		target_x_position = position.x + move_offset

	$AnimatedSprite2D.flip_h = direction.x > 0
