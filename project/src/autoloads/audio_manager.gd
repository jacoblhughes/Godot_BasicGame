extends Node


##main
#@export var main_applause : AudioStreamWAV
#@export var main_game_over : AudioStreamWAV

@export var background_music : AudioStreamWAV
@export var background_music_2 : AudioStreamWAV

##perry_says
#@export var perry_says_c_low : AudioStreamWAV
#@export var perry_says_d : AudioStreamWAV
#@export var perry_says_e : AudioStreamWAV
#@export var perry_says_f : AudioStreamWAV
#@export var perry_says_g : AudioStreamWAV
#@export var perry_says_a : AudioStreamWAV
#@export var perry_says_b : AudioStreamWAV
#@export var perry_says_c : AudioStreamWAV
#
#
##perry_polo
#@export var perry_polo_ball_hit : AudioStreamWAV
#@export var perry_polo_whirlpool_sounds : Array[AudioStreamWAV]
#
##perry_space
#@export var perry_space_rocket_shoot : AudioStreamWAV
#@export var perry_space_player_hit : AudioStreamWAV
#@export var perry_space_enemy_die : AudioStreamWAV

@export var path_to_sfx_folder : String

var background_animation_player : AnimationPlayer = null
var background_player : AudioStreamPlayer = null
var background_player_2 : AudioStreamPlayer = null
# Export the NodePath to the player_initials scene

var background_playing : bool = false
var background_level : float = 0.0
var game_effects_playing : bool = false
var game_effects_level : float = 0.0

var buses = {"Game": 8} # Define the number of players for each bus

var available = {}  # Dictionary to hold available players for each bus
var queues = {}  # Dictionary to hold queues for each bus

var background_player_length
var background_player_2_length

var audio_files = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var game_audio_node = Node.new()
	game_audio_node.name = "GameAudio"
	add_child(game_audio_node)

	var background_audio_node = Node.new()
	background_audio_node.name = "BackgroundAudio"
	add_child(background_audio_node)

	for bus in buses.keys():
		available[bus] = []
		queues[bus] = []
		for i in range(buses[bus]):
			var p = AudioStreamPlayer.new()
			game_audio_node.add_child(p)  # Add to the game audio parent node
			available[bus].append(p)
			p.connect("finished", Callable(self, "_on_stream_finished").bind(bus, p))
			p.name = "Game" + str(i + 1)
			p.bus = bus


	background_player = AudioStreamPlayer.new()
	background_player.name = "Background"
	background_player.stream = background_music
	background_player_length = background_player.stream.get_length()

	background_audio_node.add_child(background_player)
	background_player.bus = "Background"
	background_player_2 = AudioStreamPlayer.new()
	background_player_2.name = "Background2"
	background_player_2.stream = background_music_2
	background_player_2_length = background_player_2.stream.get_length()

	background_audio_node.add_child(background_player_2)
	background_player_2.bus = "Background"
	background_animation_player = AnimationPlayer.new()
	background_animation_player.name = "BackgroundAnimationPlayer"
	background_audio_node.add_child(background_animation_player)

	var animation_library = AnimationLibrary.new()

	var overall_length = 2.0
	var high_easing = 10.0
	var low_easing = 0.25

	# Create the FadeToTrack1 animation
	var fade_to_track1 = Animation.new()
	fade_to_track1.resource_name = "FadeToTrack1"
	fade_to_track1.length = overall_length
	fade_to_track1.loop_mode = 0  # Set animation to loop

	# Track for background_player volume_db
	fade_to_track1.add_track(Animation.TYPE_VALUE)
	fade_to_track1.track_set_path(0, NodePath("Background:volume_db"))
	fade_to_track1.track_set_interpolation_type(0, Animation.INTERPOLATION_LINEAR)
	fade_to_track1.track_insert_key(0, 0.0, -80.0,low_easing)
	#fade_to_track1.track_set_key_transition(0,0.0,.25)
	fade_to_track1.track_insert_key(0, overall_length, 0.0,low_easing)
	#fade_to_track1.track_set_key_transition(0,5.0,.25)

	# Track for background_player_2 volume_db
	fade_to_track1.add_track(Animation.TYPE_VALUE)
	fade_to_track1.track_set_path(1, NodePath("Background2:volume_db"))
	fade_to_track1.track_set_interpolation_type(1, Animation.INTERPOLATION_LINEAR)
	fade_to_track1.track_insert_key(1, 0.0, 0.0, low_easing)
	#fade_to_track1.track_set_key_transition(1,0.0,5.5)
	fade_to_track1.track_insert_key(1, overall_length, -80.0, low_easing)
	#fade_to_track1.track_set_key_transition(1,5.0,5.5)
	# Track for background_player_2 playing state
	fade_to_track1.add_track(Animation.TYPE_VALUE)
	fade_to_track1.track_set_path(2, NodePath("Background2:playing"))
	fade_to_track1.track_set_interpolation_type(2, Animation.INTERPOLATION_LINEAR)
	fade_to_track1.track_insert_key(2, overall_length, false)

	# Add FadeToTrack1 animation to AnimationLibrary
	animation_library.add_animation("FadeToTrack1", fade_to_track1)

	# Create the FadeToTrack2 animation
	var fade_to_track2 = Animation.new()
	fade_to_track2.resource_name = "FadeToTrack2"
	fade_to_track2.length = overall_length
	fade_to_track2.loop_mode = 0  # Set animation to loop

	# Track for background_player volume_db
	fade_to_track2.add_track(Animation.TYPE_VALUE)
	fade_to_track2.track_set_path(0, NodePath("Background:volume_db"))
	fade_to_track2.track_set_interpolation_type(0, Animation.INTERPOLATION_LINEAR)
	fade_to_track2.track_insert_key(0, 0.0, 0.0, low_easing)
	#fade_to_track2.track_set_key_transition(0,0.0,5.5)
	fade_to_track2.track_insert_key(0, overall_length, -80.0, low_easing)
	#fade_to_track2.track_set_key_transition(0,5.0,5.5)
	# Track for background_player playing state
	fade_to_track2.add_track(Animation.TYPE_VALUE)
	fade_to_track2.track_set_path(1, NodePath("Background:playing"))
	fade_to_track2.track_set_interpolation_type(1, Animation.INTERPOLATION_LINEAR)
	fade_to_track2.track_insert_key(1, overall_length, false)

	# Track for background_player_2 volume_db
	fade_to_track2.add_track(Animation.TYPE_VALUE)
	fade_to_track2.track_set_path(2, NodePath("Background2:volume_db"))
	fade_to_track2.track_set_interpolation_type(2, Animation.INTERPOLATION_LINEAR)
	fade_to_track2.track_insert_key(2, 0.0, -80.0, low_easing)
	#fade_to_track2.track_set_key_transition(2,0.0,.25)
	fade_to_track2.track_insert_key(2, overall_length, 0.0, low_easing)
	#fade_to_track2.track_set_key_transition(2,5.0,.25)
	# Add FadeToTrack2 animation to AnimationLibrary
	animation_library.add_animation("FadeToTrack2", fade_to_track2)

	# Set the animation library to the AnimationPlayer
	background_animation_player.add_animation_library("AnimationLib",animation_library)

	# Optionally, play the animations
	# background_animation_player.play("FadeToTrack1")
	# background_animation_player.play("FadeToTrack2")
	load_sfx_files()

func crossfade_to() -> void:

	# If both tracks are playing, we're calling the function in the middle of a fade.
	# We return early to avoid jumps in the sound.
	if background_player.playing and background_player_2.playing:
		return

	# The `playing` property of the stream players tells us which track is active.
	# If it's track two, we fade to track one, and vice-versa.
	if background_player.playing:
		background_player_2.volume_db = -80
		background_player_2.play()
		background_animation_player.play("AnimationLib/FadeToTrack2")
	else:
		background_player.volume_db = -80
		background_player.play()
		background_animation_player.play("AnimationLib/FadeToTrack1")

func stop_all_background_music():
	background_player.stop()
	background_player_2.stop()


func _on_stream_finished(bus, player):
	# When finished playing a stream, make the player available again.
	available[bus].append(player)

func play_sound(sound_name: String):

	if audio_files.has(sound_name):
		queues["Game"].append(audio_files[sound_name])
	else:
		print("Sound not recognized")


func _process(delta):

	if ((background_player.get_playback_position() > background_player_length - 2)
		or
		(background_player_2.get_playback_position() > background_player_2_length - 2)
		):
			crossfade_to()

	for bus in queues.keys():
		if not queues[bus].is_empty() and not available[bus].is_empty():


			var player = available[bus].pop_front()
			var audio_stream = queues[bus].pop_front()
			if audio_stream:
				player.stream = audio_stream
				player.play()
			else:
				print("Failed to load audio stream")


func set_background_music_mute(true_or_false):

	background_playing = true_or_false
	var _this_bus_index = AudioServer.get_bus_index("Background")
	if(background_playing):

		crossfade_to()
		AudioServer.set_bus_mute(_this_bus_index,false)
		GameManager.save_background_music_choice(background_playing)
	else:
		stop_all_background_music()
		AudioServer.set_bus_mute(_this_bus_index,true)
		GameManager.save_background_music_choice(background_playing)
	pass # Replace with function body.





func get_background_music_status():
	return background_playing

func set_game_music_mute(true_or_false):
	game_effects_playing = true_or_false

	var _this_bus_index = AudioServer.get_bus_index("Game")
	if(game_effects_playing):
		AudioServer.set_bus_mute(_this_bus_index,false)
		GameManager.save_game_effects_choice(game_effects_playing)
	if(!game_effects_playing):
		AudioServer.set_bus_mute(_this_bus_index,true)
		GameManager.save_game_effects_choice(game_effects_playing)
	pass # Replace with function body.

func get_game_music_status():
	return game_effects_playing

func update_background_music(value):

	background_level = value
	var _this_bus_index = AudioServer.get_bus_index("Background")
	AudioServer.set_bus_volume_db(_this_bus_index,linear_to_db(value))
	GameManager.save_background_music_value(value)

	pass


func get_background_music_level():
	return background_level


func update_game_music(value):
	game_effects_level = value
	var _this_bus_index = AudioServer.get_bus_index("Game")
	AudioServer.set_bus_volume_db(_this_bus_index,linear_to_db(value))
	GameManager.save_game_effects_value(game_effects_level)
	pass


func get_game_music_level():
	return game_effects_level

func load_sfx_files():
	var dir_access = DirAccess.open(path_to_sfx_folder)

	if dir_access:
		dir_access.list_dir_begin()
		var file_name = dir_access.get_next()

		while file_name != "":
			if file_name != "." and file_name != "..":
				var game_path = path_to_sfx_folder.path_join(file_name)
				if dir_access.current_is_dir() and file_name.begins_with("perry_"):
					# Check if "sounds" folder exists in the game directory
					var sounds_path = game_path.path_join("sounds")
					var sounds_dir_access = DirAccess.open(sounds_path)
					if sounds_dir_access:
						sounds_dir_access.list_dir_begin()
						var sound_file_name = sounds_dir_access.get_next()

						while sound_file_name != "":
							if sound_file_name != "." and sound_file_name != "..":
								var sound_file_path = sounds_path.path_join(sound_file_name)
								if sound_file_name.ends_with(".import"):
									sound_file_path = sound_file_path.replace(".import", "")
									sound_file_name = sound_file_name.replace(".import", "")

								if (!sounds_dir_access.current_is_dir() and sound_file_name.ends_with(".wav")):
									var audio_stream = load(sound_file_path) as AudioStreamWAV

									if audio_stream:
										audio_files[sound_file_name.get_basename()] = audio_stream
							sound_file_name = sounds_dir_access.get_next()
						sounds_dir_access.list_dir_end()
			file_name = dir_access.get_next()
		dir_access.list_dir_end()
	else:
		print("Error opening directory:", path_to_sfx_folder)

