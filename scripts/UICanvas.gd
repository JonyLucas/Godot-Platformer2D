extends CanvasLayer

var coin_label

func update_level_manager():
	var level_manager = get_tree().get_first_node_in_group("level_manager")
	coin_label = $MarginContainer/HBoxContainer/CoinLabel

	if level_manager:
		print("Level manager found")
		level_manager.connect("coin_collected_signal", update_coin_score, CONNECT_DEFERRED)
		update_coin_score(0, level_manager.total_coins)

func update_coin_score(coins_collected, total_coins):
	print("Coins collected: " + str(coins_collected) + " / " + str(total_coins))
	coin_label.text = str(coins_collected) + " / " + str(total_coins)
