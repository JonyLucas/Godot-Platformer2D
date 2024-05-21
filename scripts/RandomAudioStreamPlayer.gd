extends Node

@export var simultanous_stream_players: int = 2
@export var enable_pitch_randomization: bool = true
@export var min_pitch_randomization: float = 0.9
@export var max_pitch_randomization: float = 1.1

func play() -> void:
	var audio_children = get_children().filter(func(child): return is_instance_of(child, AudioStreamPlayer) and !child.playing)
	audio_children.shuffle()
	for i in range(min(simultanous_stream_players, audio_children.size())):
		if enable_pitch_randomization:
			audio_children[i].pitch_scale = randf_range(min_pitch_randomization, max_pitch_randomization)
		audio_children[i].play()

