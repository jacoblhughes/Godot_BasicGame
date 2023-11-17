extends Node

# Export the NodePath to the player_initials scene
var config = ConfigFile.new()

@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer
@onready var hud_control : Control
@onready var aspect_ratio_container :Control

var background_playing : bool
var background_level : int
var game_playing : bool
var game_level : int
var perry_arcade_path = "user://perry_arcade.cfg"



# Called when the node enters the scene tree for the first time.
func _ready():
	aspect_ratio_container = get_tree().get_root().get_node("Main").get_node("AspectRatioContainer").get_node("Control")
	hud_control = aspect_ratio_container.get_node("HUD")
	GameOverSound = hud_control.get_node("GameOver")
	ApplauseSound = hud_control.get_node("Applause")
	BackGroundMusic = hud_control.get_node("BackGroundMusic")
	print(BackGroundMusic,"iiiiii")
	pass

func set_background_music_mute(true_or_false):
	print(true_or_false)
	background_playing = true_or_false
	var _this_bus_index = AudioServer.get_bus_index("Background")
	print(_this_bus_index)
	print(BackGroundMusic)
	print(aspect_ratio_container)
	if(background_playing):
		AudioManager.BackGroundMusic.play()
		AudioServer.set_bus_mute(_this_bus_index,false)
		
	if(!background_playing and AudioManager.BackGroundMusic.playing):
		AudioManager.BackGroundMusic.stop()
		AudioServer.set_bus_mute(_this_bus_index,true)
		return
	elif(!background_playing and !AudioManager.BackGroundMusic.playing):
		AudioServer.set_bus_mute(_this_bus_index,true)
		
	pass # Replace with function body.
	
func get_background_music_status():
	return background_playing

func set_game_music_mute(true_or_false):
	game_playing = true_or_false
	var _this_bus_index = AudioServer.get_bus_index("Game")
	if(game_playing):

		AudioServer.set_bus_mute(_this_bus_index,false)
	if(!game_playing):

		AudioServer.set_bus_mute(_this_bus_index,true)
	pass # Replace with function body.
	
func get_game_music_status():
	return game_playing
	
func update_background_music(value):
	background_level = value
	var _this_bus_index = AudioServer.get_bus_index("Background")
	AudioServer.set_bus_volume_db(_this_bus_index,linear_to_db(value))
	
	pass

func get_background_music_level():
	return background_level

func game_file_ready():
		game_file_ready = true
	set_background_music_mute(background_playing)
	set_game_music_mute(game_playing)
	update_background_music(background_level)
