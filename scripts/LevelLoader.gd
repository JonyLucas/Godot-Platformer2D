extends Node

@export var levels: Array[PackedScene] = []

var current_level_index: int = 0
var current_level

func _ready():
	change_level(0)

func change_level(level_index: int) -> void:
	current_level_index = level_index
	if current_level_index >= levels.size():
		current_level_index = 0
	
	if current_level != null:
		current_level.queue_free()

	current_level = levels[current_level_index].instantiate()
	$"/root/Main/LevelLoader".add_child(current_level)

func load_next_level() -> void:
	print("Loading next level")
	change_level(current_level_index + 1)