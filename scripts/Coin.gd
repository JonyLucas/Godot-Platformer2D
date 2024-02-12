extends Node2D

func _on_area_entered(body):
	if body.get_parent().has_method("collect_coin"): 
		body.get_parent().collect_coin()
		call_deferred("disable_collision")
		$AnimationPlayer.play("pickup")


func disable_collision():
	$Area2D/CollisionShape2D.disabled = true

