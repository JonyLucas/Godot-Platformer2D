extends CharacterBody2D

@export var max_speed = 200
@export var gravity = 500
var direction = Vector2.RIGHT

func _process(delta):
	velocity.x = direction.x * max_speed * delta
	velocity.y += gravity * delta
	move_and_slide()

	$AnimatedSprite2D.flip_h = direction.x < 0
