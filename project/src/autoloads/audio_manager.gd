extends Node


#main
@export var main_applause : AudioStreamWAV 
@export var main_game_over : AudioStreamWAV 
@export var main_background_music : AudioStreamWAV 


#perry_polo
@export var perry_polo_ball_hit : AudioStreamWAV 
@export var perry_polo_wave_sound : AudioStreamWAV 
@export var perry_polo_background_music : AudioStreamWAV
# Export the NodePath to the player_initials scene

var background_playing : bool = false
var background_level : float = 0.0
var game_effects_playing : bool = false
var game_effects_level : float = 0.0

var buses = {"Game": 8, "Background": 4}  # Define the number of players for each bus

var available = {}  # Dictionary to hold available players for each bus
var queues = {}  # Dictionary to hold queues for each bus
var playing = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for bus in buses.keys():
		available[bus] = []
		queues[bus] = []
		playing[bus] = []
		for i in range(buses[bus]):
			var p = AudioStreamPlayer.new()
			add_child(p)
			available[bus].append(p)
			p.connect("finished", Callable(self, "_on_stream_finished").bind(bus, p))
			p.bus = bus
			
			

func _on_stream_finished(bus, player):
	# When finished playing a stream, make the player available again.
	available[bus].append(player)

func play(sound_path, bus):
	if bus in queues:
		queues[bus].append(sound_path)
	else:
		print("Bus not recognized")
		
func play_sound(sound_name: String):
	match sound_name:
		"perry_polo_ball_hit":
				queues["Game"].append(perry_polo_ball_hit)
		"main_applause":
				queues["Game"].append(main_applause)
		"main_game_over":
				queues["Game"].append(main_game_over)
		"main_background_music":
				queues["Background"].append(main_background_music)
		_:
			print("Sound not recognized")

func stop_background_sound():
	print(available)
	print(queues)
	if not playing["Background"].is_empty():
		for node in playing["Background"]:
			node.stop()
			available["Background"].append(node)
		
func _process(delta):

	for bus in queues.keys():
		if not queues[bus].is_empty() and not available[bus].is_empty():

			
			var player = available[bus].pop_front()
			var audio_stream = queues[bus].pop_front()
			if audio_stream:
				player.stream = audio_stream
				player.play()
				playing[bus].append(player)
			else:
				print("Failed to load audio stream")
				

func set_background_music_mute(true_or_false):
	background_playing = true_or_false
	var _this_bus_index = AudioServer.get_bus_index("Background")
	if(background_playing):
		play_sound("main_background_music")
		AudioServer.set_bus_mute(_this_bus_index,false)
		GameManager.save_background_music_choice(background_playing)
	else:
		stop_background_sound()
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
