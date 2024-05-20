extends Node

@export var levels: Array[PackedScene] = []

var current_level_index: int = 0
var current_level

func _ready():
	change_level(0)

func change_level(level_index: int) -> void:
	current_level_index = level_index
	if current_level_index >= levels.size():
		get_tree().change_scene_to_file("res://scenes/ui/game_complete.tscn")
		return
	
	if current_level != null:
		$"/root/Main/LevelLoader".remove_child(current_level)
		current_level.queue_free()
	
	var screen_trasition = $"/root/Main/TransitionLayer"
	screen_trasition.visible = true
	var transition_animation = $"/root/Main/TransitionLayer/AnimationPlayer"
	transition_animation.play("end_transition")

	current_level = levels[current_level_index].instantiate()
	$"/root/Main/LevelLoader".add_child(current_level)

func load_next_level() -> void:
	change_level(current_level_index + 1)

func restart_level() -> void:
	change_level(current_level_index)
