extends CharacterBody2D

enum state { NORMAL, DASHING }

@export var speed_acceleration = 100.0
@export var max_speed = 500.0
@export var max_dash_speed = 1000.0
@export var min_dash_speed = 500.0
@export var desacceleration_rate = 50.0
@export var dash_desacceleration_rate = 6.0
@export var gravity = 300.0
@export var jump_force = 200.0
@export var jump_force_multiplier = 3.0
var reset_coyote_timer = true
var has_double_jump = true
var current_state = state.NORMAL
var start_dashing = false

signal player_death_signal

func _process(delta):
	var move_direction = get_move_direction()
	match current_state:
		state.NORMAL:
			update_velocity(move_direction, delta)
			update_animation()
			move_and_slide()
		state.DASHING:
			process_dashing(delta)

func get_move_direction() -> Vector2:	
	var direction = Vector2()
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = -jump_force if check_jump_condition() and Input.is_action_just_pressed("jump") else 0.0
	
	if Input.is_action_just_pressed("dash"):
		current_state = state.DASHING
		start_dashing = true

	return direction

func check_jump_condition() -> bool:
	if is_on_floor():
		reset_coyote_timer = true
		has_double_jump = true
		return true
	elif !$CoyoteTimer.is_stopped():
		return true
	elif has_double_jump and Input.is_action_just_pressed("jump"):
		has_double_jump = false
		return true
	else:
		if reset_coyote_timer:
			$CoyoteTimer.start()
			reset_coyote_timer = false

		return false

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


func update_animation():
	if !is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = velocity.x > 0
	else:
		$AnimatedSprite2D.play("idle")

func process_dashing(delta: float):
	if start_dashing:
		$AnimatedSprite2D.play("jump")
		velocity.x = max_dash_speed if $AnimatedSprite2D.flip_h else -max_dash_speed
		velocity.y = 0.0
		start_dashing = false
	else:
		velocity.x = lerp(velocity.x, 0.0, dash_desacceleration_rate * delta)
		if abs(velocity.x) <= min_dash_speed:
			current_state = state.NORMAL
	move_and_slide()

func collect_coin():
	pass

func die():
	print("Player died")
	emit_signal("player_death_signal")
