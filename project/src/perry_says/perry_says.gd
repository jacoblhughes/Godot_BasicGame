extends Node2D


var arrayOfPlayerResponse = []
var arrayOfButtonsToFollow = []
var objectOfButtonsForMapping = {}
var buttonToAdd = 0
var rng = RandomNumberGenerator.new()

var groupOfButtons

var disabledColor
var score_value = 1
var level_value = 1
var level_advance_value = 10
var playerTurn = false
var computerPopulate = 0
var playerPopulate = -1
var button_pressed
var buttonObject = {}

var high_scores_for_popup
var high_scores_names
var high_scores

@onready var playback_timer : Timer
var sounds = []
# Called when the node enters the scene tree for the first time.
func _ready():
	playback_timer = get_parent().get_node("PlaybackTimer")
	sounds = [preload("res://sounds/perry_says/c_low.wav"),preload("res://sounds/perry_says/d.wav")
	,preload("res://sounds/perry_says/e.wav"),preload("res://sounds/perry_says/f.wav")
	,preload("res://sounds/perry_says/g.wav"),preload("res://sounds/perry_says/a.wav")
	,preload("res://sounds/perry_says/b.wav"),preload("res://sounds/perry_says/c.wav")]

	
func _game_initialize():
	HUD.reset_score()
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_level(level_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if(playerTurn):
		if(len(arrayOfPlayerResponse)>0):
			if(arrayOfButtonsToFollow[playerPopulate] == arrayOfPlayerResponse[playerPopulate]):
				if(len(arrayOfButtonsToFollow) == len(arrayOfPlayerResponse)):
					_set_buttons_disabled(true)
					_player_turn_end()
					_computer_turn_start()
			else:
				_game_lose()

func _game_lose():
	HUD.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
	_set_buttons_disabled(true)
	HUD.reset_score()
	GameManager.set_game_enabled(false)
	computerPopulate = 0
	arrayOfButtonsToFollow = []
	_stop_game_button_sounds()
	_stop_game_button_animations_and_timer()
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1
	
func _initialize_buttons():
	for node in get_tree().get_nodes_in_group("perry_says_buttons"):
		node.remove_from_group("perry_says_buttons")
	var button_node = get_parent().get_node("Buttons").get_children()
	var i = 0
	for node in button_node:
		node.sprite_number = i * 2
		node.add_to_group("perry_says_buttons")
		node.perry_pressed.connect(_on_game_button_pressed)
		node.button_number = i
		node.texture_button.disabled = true
		node.initiate_button()

		var audio_stream_wav = AudioStream.new()
		audio_stream_wav = sounds[i]
		node.audio_stream_player.set_stream(audio_stream_wav)
		i+=1
	groupOfButtons = get_tree().get_nodes_in_group("perry_says_buttons")

func _computer_turn_start():
	_set_buttons_disabled(true)
	_add_next_value()
	playback_timer.start()
	
func _set_buttons_disabled(setting):

	for i in len(groupOfButtons):
		groupOfButtons[i].texture_button.disabled = setting

func _player_turn_end():
	HUD.update_score(score_value)
	_check_advance_level()
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1

func _check_advance_level():
	if(HUD.get_score() % level_advance_value == 0):
		HUD.update_game_level(level_value)
		for button in groupOfButtons:
			button.play_time = button.original_time * pow(.95,GameManager.get_game_level())

func _get_next_value():
	buttonToAdd = floor(rng.randf_range(0, 8))
	return buttonToAdd
	
func _add_next_value():
	arrayOfButtonsToFollow.append(_get_next_value())
	pass # Replace with function body.
	
func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	_computer_turn_start()
	pass # Replace with function body.
	
func _on_playback_timer_timeout():
	groupOfButtons[arrayOfButtonsToFollow[computerPopulate]].called_from_game()
	computerPopulate+=1
	if(computerPopulate == len(arrayOfButtonsToFollow)):

		playerTurn = true

		computerPopulate = 0
		_set_buttons_disabled(false)
		playback_timer.stop()
		
	pass # Replace with function body.

func _stop_game_button_sounds():
#	for button in groupOfButtons:
#		button.sound.stop()
	pass
	
func _stop_game_button_animations_and_timer():
	for button in groupOfButtons:
		button.animated_sprite.stop()
		button.animated_sprite.play('default')
	playback_timer.stop()
	



func _on_game_button_pressed(which):
	if(playerTurn):
		arrayOfPlayerResponse.append(which)
		playerPopulate += 1


func _on_buttons_ready():
	await _initialize_buttons()

	_game_initialize()
	pass # Replace with function body.
