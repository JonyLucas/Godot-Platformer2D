extends CharacterBody2D

@export var speed_acceleration = 100.0
@export var max_speed = 500.0
@export var desacceleration_rate = 50.0
@export var gravity = 300.0
@export var jump_force = 200.0
@export var jump_force_multiplier = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_direction = get_move_direction()
	update_velocity(move_direction, delta)
	move_and_slide()

func get_move_direction() -> Vector2:
	var direction = Vector2()
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = -jump_force if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	return direction

func update_velocity(move_direction: Vector2, delta: float):
	if move_direction.x == 0:
		velocity.x = lerp(velocity.x, 0.0, desacceleration_rate * delta)
	else :
		velocity.x += speed_acceleration * move_direction.x * delta

	velocity.x = clamp(velocity.x, -max_speed, max_speed)

	if velocity.y < 0 and not Input.is_action_pressed("jump"):
		velocity.y += gravity * jump_force_multiplier * delta + move_direction.y
	else:
		velocity.y += gravity * delta + move_direction.y
