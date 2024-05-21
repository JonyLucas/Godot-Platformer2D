extends Node

@export var simultanous_stream_players: int = 2

func play() -> void:
	var audio_children = get_children().filter(func(child): return is_instance_of(child, AudioStreamPlayer) and !child.playing)
	audio_children.shuffle()
	for i in range(min(simultanous_stream_players, audio_children.size())):
		audio_children[i].play()

