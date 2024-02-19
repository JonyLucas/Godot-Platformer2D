extends Node2D

@export var is_enemy_hazard: bool = false

func _on_body_entered(body:Node2D):
	if body.has_method("die"):
		body.die(is_enemy_hazard)
