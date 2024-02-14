extends Node

var player_scene = preload("res://scenes/player.tscn")
var spawn_position = Vector2(0, 0)
var player_ref

func _ready():
	spawn_position = $PlayerNode/Player.global_position
	register_player($PlayerNode/Player)

func register_player(playerNode):
	player_ref = playerNode
	player_ref.connect("player_death_signal", on_player_death, CONNECT_DEFERRED)

func create_player():
	var player = player_scene.instantiate()
	$PlayerNode.add_child(player)
	player.global_position = spawn_position
	register_player(player)

func on_player_death():
	player_ref.queue_free()
	create_player()

