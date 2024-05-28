extends Marker2D

@export var enemy_scene: PackedScene
@export var enemy_count: int
@export var enemy_target_offset: float
@export var enemy_direction: Vector2 = Vector2.RIGHT

var current_enemy: Node2D = null
var spawn_on_next_timeout: bool = false

func _ready():
	call_deferred("spawn_enemy")


func spawn_enemy():
	if enemy_scene != null:
		current_enemy = enemy_scene.instantiate()
		current_enemy.global_position = global_position
		get_parent().add_child(current_enemy)
		current_enemy.move_offset = enemy_target_offset
		current_enemy.direction = enemy_direction
		enemy_count -= 1


func _on_spawn_timeout():
	if is_instance_valid(current_enemy) or enemy_count <= 0:
		return
	
	if spawn_on_next_timeout:
		spawn_on_next_timeout = false
		return

	spawn_enemy()
	spawn_on_next_timeout = false
