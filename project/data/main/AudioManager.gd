extends Node

# Export the NodePath to the player_initials scene
var config = ConfigFile.new()



@onready var BackGroundMusic: AudioStreamPlayer
@onready var hud_control : Control
@onready var aspect_ratio_container :Control

var background_playing : bool
var background_level : float
var game_playing : bool
var game_level : float
var perry_arcade_path = "user://perry_arcade.cfg"
var config_file_path


# Called when the node enters the scene tree for the first time.
func _ready():
	aspect_ratio_container = get_tree().get_root().get_node("Main")
	hud_control = aspect_ratio_container.get_node("HUD")


	BackGroundMusic = hud_control.get_node("BackGroundMusic")
	config_file_path = config.load("user://perry_arcade.cfg")
	pass

func set_background_music_mute(true_or_false):
	background_playing = true_or_false
	var _this_bus_index = AudioServer.get_bus_index("Background")
	if(background_playing):
		BackGroundMusic.play()
		AudioServer.set_bus_mute(_this_bus_index,false)
		config.set_value("background_music","playing",1)
		config.save(perry_arcade_path)
		return
	if(!background_playing and AudioManager.BackGroundMusic.playing):
		BackGroundMusic.stop()
		AudioServer.set_bus_mute(_this_bus_index,true)
		config.set_value("background_music","playing",0)
		config.save(perry_arcade_path)
		return
	elif(!background_playing and !AudioManager.BackGroundMusic.playing):
		AudioServer.set_bus_mute(_this_bus_index,true)
		config.set_value("background_music","playing",0)
		config.save(perry_arcade_path)
		return
	pass # Replace with function body.
	
func get_background_music_status():
	return background_playing

func set_game_music_mute(true_or_false):
	game_playing = true_or_false

	var _this_bus_index = AudioServer.get_bus_index("Game")
	if(game_playing):
		AudioServer.set_bus_mute(_this_bus_index,false)
		config.set_value("game_music","playing",1)
		config.save(perry_arcade_path)
	if(!game_playing):
		AudioServer.set_bus_mute(_this_bus_index,true)
		config.set_value("game_music","playing",0)
		config.save(perry_arcade_path)
	pass # Replace with function body.
	
func get_game_music_status():
	return game_playing
	
func update_background_music(value):

	background_level = value
	var _this_bus_index = AudioServer.get_bus_index("Background")
	AudioServer.set_bus_volume_db(_this_bus_index,linear_to_db(value))
	config.set_value("background_music","value",value)
	config.save(perry_arcade_path)

	pass
	

func get_background_music_level():
	return background_level
	
	
func update_game_music(value):
	game_level = value
	var _this_bus_index = AudioServer.get_bus_index("Game")
	AudioServer.set_bus_volume_db(_this_bus_index,linear_to_db(value))
	config.set_value("game_music","value",value)
	config.save(perry_arcade_path)
	pass
	

func get_game_music_level():

	return game_level

func game_file_ready():

	set_background_music_mute(background_playing)
	set_game_music_mute(game_playing)
	update_background_music(background_level)
	update_game_music(game_level)
