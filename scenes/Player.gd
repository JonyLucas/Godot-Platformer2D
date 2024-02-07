extends CharacterBody2D

@export var speed = 100
@export var jump_force = 200
var gravity = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var jump = -jump_force if Input.is_action_just_pressed("jump") and is_on_floor() else 0
	velocity.x = speed * direction
	velocity.y += gravity * delta + jump
	move_and_slide()
