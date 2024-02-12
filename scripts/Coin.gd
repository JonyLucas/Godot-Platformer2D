extends Node2D

func _on_area_entered(body):
	if body.get_parent().has_method("collect_coin"): 
		body.get_parent().collect_coin()
		$Area2D/CollisionShape2D.disabled = false
		$AnimationPlayer.play("pickup")

func _on_collect_animation_finished(anim_name:StringName):
	if anim_name == "pickup":
		queue_free()
