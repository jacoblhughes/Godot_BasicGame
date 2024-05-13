extends Node

# Export the NodePath to the player_initials scene
var config = ConfigFile.new()

var background_playing : bool = false
var background_level : float = 0.0
var game_effects_playing : bool = false
var game_effects_level : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func set_background_music_mute(true_or_false):
	background_playing = true_or_false
	var _this_bus_index = AudioServer.get_bus_index("Background")
	if(background_playing):
		%BackGroundMusic.play()
		AudioServer.set_bus_mute(_this_bus_index,false)
		GameManager.save_background_music_choice(background_playing)

		return
	if(!background_playing and %BackGroundMusic.playing):
		%BackGroundMusic.stop()
		AudioServer.set_bus_mute(_this_bus_index,true)
		GameManager.save_background_music_choice(background_playing)
		return
	elif(!background_playing and !%BackGroundMusic.playing):
		AudioServer.set_bus_mute(_this_bus_index,true)
		GameManager.save_background_music_choice(background_playing)
		return
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
