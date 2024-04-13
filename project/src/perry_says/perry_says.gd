extends Node2D


var arrayOfPlayerResponse = []
var arrayOfButtonsToFollow = []
var objectOfButtonsForMapping = {}
var buttonToAdd = 0
var rng = RandomNumberGenerator.new()

var groupOfButtons

var disabledColor
var score_value = 1

var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable

var playerTurn = false
var computerPopulate = 0
var playerPopulate = -1
var button_pressed
var buttonObject = {}


var sounds = []
# Called when the node enters the scene tree for the first time.
func _ready():

	sounds = [preload("res://sounds/perry_says/c_low.wav"),preload("res://sounds/perry_says/d.wav")
	,preload("res://sounds/perry_says/e.wav"),preload("res://sounds/perry_says/f.wav")
	,preload("res://sounds/perry_says/g.wav"),preload("res://sounds/perry_says/a.wav")
	,preload("res://sounds/perry_says/b.wav"),preload("res://sounds/perry_says/c.wav")]
	
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()
	await _initialize_buttons()


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
				HUD.update_lives(-1)

func _game_lose():
	GameStartGameOver.set_gameover_panel(true)
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
	var button_node_children = %Buttons.get_children()
	var i = 0
	for node in button_node_children:
		node.sprite_number = i * 2
		node.add_to_group("perry_says_buttons")
		node.perry_pressed.connect(_on_game_button_pressed)
		node.button_number = i
#		node.texture_button.disabled = true
		node.initiate_button()
		var audio_stream_wav = AudioStream.new()
		audio_stream_wav = sounds[i]
		node.audio_stream_player.set_stream(audio_stream_wav)
		i+=1
	groupOfButtons = get_tree().get_nodes_in_group("perry_says_buttons")

func _computer_turn_start():
	_set_buttons_disabled(true)
	_add_next_value()
	print('heeeeeee')
	%PlaybackTimer.start()
	
func _set_buttons_disabled(setting):

#	for i in len(groupOfButtons):
#		groupOfButtons[i].texture_button.disabled = setting
	pass
func _player_turn_end():
	HUD.update_score(score_value)
	if HUD.check_advance_level():
		advance_level()
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1

func advance_level():
	for button in groupOfButtons:
		button.play_time = button.original_time * pow(.95,HUD.get_game_level())
	%PlaybackTimer.wait_time = %PlaybackTimer.original_time * pow(.95,HUD.get_game_level())

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
	print(computerPopulate)
	groupOfButtons[arrayOfButtonsToFollow[computerPopulate]].called_from_game()
	computerPopulate+=1
	if(computerPopulate == len(arrayOfButtonsToFollow)):

		playerTurn = true

		computerPopulate = 0
		_set_buttons_disabled(false)
		%PlaybackTimer.stop()
		
	pass # Replace with function body.

func _stop_game_button_sounds():
#	for button in groupOfButtons:
#		button.sound.stop()
	pass
	
func _stop_game_button_animations_and_timer():
	for button in groupOfButtons:
		button.animated_sprite.stop()
		button.animated_sprite.play('default')
	%PlaybackTimer.stop()

func _on_game_button_pressed(which):
	if(playerTurn):
		arrayOfPlayerResponse.append(which)
		playerPopulate += 1


func _on_buttons_ready():

	pass # Replace with function body.
