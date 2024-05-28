extends Node2D

@export_multiline var tutorial_text: String
@export var label_text: Label

var can_interact = false
var panel_container

func _ready():
	panel_container = get_node("PanelContainer")
	label_text.text = tutorial_text
	panel_container.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("interact") and can_interact:
		$AnimationPlayer.play("on_enter")

func _on_body_entered(_body:Node2D):
	$Sprite2D.frame = 1
	can_interact = true


func _on_body_exited(_body:Node2D):
	$Sprite2D.frame = 0
	can_interact = false
	$AnimationPlayer.play("on_reset")
