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
var level_manager
var player_death_scene = preload("res://scenes/player_death.tscn")
var footstep_particle = preload("res://scenes/footstep.tscn")

signal player_death_signal

func _ready():
	level_manager = get_tree().get_first_node_in_group("level_manager")

func _process(delta):
	if is_instance_valid(level_manager) and (level_manager.is_paused or level_manager.is_level_completed):
		return

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
	
	if Input.is_action_just_pressed("dash") and current_state == state.NORMAL:
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
		$"/root/Helpers".apply_camera_shake(0, 0.1)
		$AnimatedSprite2D.play("jump")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = velocity.x > 0
	else:
		$AnimatedSprite2D.play("idle")

func process_dashing(delta: float):
	if start_dashing:
		$DashParticles.emitting = true
		$"/root/Helpers".apply_camera_shake(0, 0.4)
		$AnimatedSprite2D.play("jump")
		$DashArea/CollisionShape2D.disabled = false
		velocity.x = max_dash_speed if $AnimatedSprite2D.flip_h else -max_dash_speed
		velocity.y = 0.0
		start_dashing = false
	else:
		velocity.x = lerp(velocity.x, 0.0, dash_desacceleration_rate * delta)
		if abs(velocity.x) <= min_dash_speed:
			$DashArea/CollisionShape2D.disabled = true
			current_state = state.NORMAL
	move_and_slide()

func die(is_enemy_hazard: bool):
	if is_enemy_hazard and current_state == state.DASHING:
		return

	$"/root/Helpers".apply_camera_shake(0, 1)	
	var death_scene = player_death_scene.instantiate()
	get_parent().add_child(death_scene)
	death_scene.global_position = global_position
	$AnimatedSprite2D.visible = false
	death_scene.velocity = velocity
	print(death_scene.global_position)
	emit_signal("player_death_signal")


func _on_dash_area_entered(body:Node2D):
	if body.is_in_group("enemy"):
		body.die()


func _on_walk_animated_changed():
	if $AnimatedSprite2D.animation == "run" and $AnimatedSprite2D.frame == 0:
		var footstep = footstep_particle.instantiate()
		get_parent().add_child(footstep)
		footstep.global_position = global_position
