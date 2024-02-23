extends Node2D

func _on_area_entered(_body):
	call_deferred("disable_collision")
	$AnimationPlayer.play("pickup")
	get_tree().get_first_node_in_group("level_manager").coin_collected()


func disable_collision():
	$Area2D/CollisionShape2D.disabled = true

