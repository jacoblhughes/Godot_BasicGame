extends Node2D


var arrayOfPlayerResponse = []
var arrayOfButtonsToFollow = []
var objectOfButtonsForMapping = {}
var buttonToAdd = 0
var rng = RandomNumberGenerator.new()

var groupOfButtons

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3

var playerTurn = false
var computerPopulate = 0
var playerPopulate = -1
var button_pressed
var buttonObject = {}


@export var sounds :Array[AudioStreamWAV] = []
# Called when the node enters the scene tree for the first time.
func _ready():

	
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()
	
	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280

#	if yform > 1280:
#		%Camera2D.enabled = true
#		%Camera2D.zoom.y = yform/1280

	if xform > 720:

		var nodes_to_move =[]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.x *= xatio

	%PlaybackTimer.timeout.connect(_on_playback_timer_timeout)

	await _initialize_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if(playerTurn):
		if(len(arrayOfPlayerResponse)>0):
			if(arrayOfButtonsToFollow[playerPopulate] == arrayOfPlayerResponse[playerPopulate]):
				if(len(arrayOfButtonsToFollow) == len(arrayOfPlayerResponse)):
					_player_turn_end()
					_computer_turn_start()
			else:
				HUD.update_lives()

func _on_game_over():
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

	_add_next_value()

	%PlaybackTimer.start()
	
func _player_turn_end():
	HUD.update_score()
	if HUD.check_advance_level():
		advance_level()
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1

func advance_level():
	for button in groupOfButtons:
		button.play_time = button.original_time * pow(.95,HUD.return_game_level())
	%PlaybackTimer.wait_time = %PlaybackTimer.original_time * pow(.95,HUD.return_game_level())

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

		%PlaybackTimer.stop()
		
	pass # Replace with function body.

func _stop_game_button_sounds():
#	for button in groupOfButtons:
#		button.sound.stop()
	pass
	
func _stop_game_button_animations_and_timer():
	%PlaybackTimer.stop()

func _on_game_button_pressed(which):
	if(playerTurn):
		arrayOfPlayerResponse.append(which)
		playerPopulate += 1
