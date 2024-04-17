extends CharacterBody2D

@export var max_speed = 200
@export var gravity = 500
@export var move_offset = 5

var enemy_death_scene = preload("res://Scenes/enemy_death.tscn")
var direction = Vector2.RIGHT
var target_x_position = 0

func _ready():
	target_x_position = position.x + move_offset

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

func die():
	$"/root/Helpers".apply_camera_shake(0, 1)
	var death_scene = enemy_death_scene.instantiate()
	death_scene.position = position
	death_scene.scale = Vector2(1, 1) if direction.x > 0 else Vector2(-1, 1)
	get_parent().add_child(death_scene)
	queue_free()
