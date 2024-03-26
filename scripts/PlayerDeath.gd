extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	$AnimationPlayer.play("death_animation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	move_and_slide()
# 	if is_on_floor():
# 		velocity = lerp(Vector2.ZERO, velocity, pow(2, -10 * delta))
