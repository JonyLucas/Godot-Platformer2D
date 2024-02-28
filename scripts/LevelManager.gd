extends Node

var player_scene = preload("res://scenes/player.tscn")
var spawn_position = Vector2(0, 0)
var player_ref
var total_coins = 0
var collected_coins = 0

signal coin_collected_signal

func _ready():
	spawn_position = $PlayerNode/Player.global_position
	register_player($PlayerNode/Player)
	total_coins = get_tree().get_nodes_in_group("coin").size()
	var goal_node = get_tree().get_first_node_in_group("goal")
	goal_node.connect("win_condition", on_win_condition, CONNECT_DEFERRED)

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

func coin_collected():
	collected_coins += 1
	print("Collected coins: ", collected_coins)
	emit_signal("coin_collected_signal", collected_coins, total_coins)

func on_win_condition():
	$"/root/Main/LevelLoader".load_next_level()
