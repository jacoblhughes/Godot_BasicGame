extends Node2D


var arrayOfPlayerResponse = []
var arrayOfButtonsToFollow = []
var objectOfButtonsForMapping = {}
var buttonToAdd = 0
var rng = RandomNumberGenerator.new()

var groupOfButtons
var groupOfButtonAnimations
var disabledColor
var score_value = 1


var playerTurn = false
var computerPopulate = 0
var playerPopulate = -1
var button_pressed
var buttonObject = {}

#var play_area_width = GameManager.get_play_area_size_from_HUD().x
#var play_area_height = GameManager.get_play_area_size_from_HUD().y
#var testing_x = (play_area_height/2)-(play_area_width/2)
#var original_game_button_x = GameManager.get_play_area_position_from_HUD().x + testing_x
#var original_game_button_y = GameManager.get_play_area_position_from_HUD().y + testing_x


var redButton
var blueButton
var greenButton
var yellowButton

var high_scores_for_popup
var high_scores_names
var high_scores

var section_name = "SimonSays"

var signalEmitted = false

@onready var redButtonScene = preload("res://scenes/SimonSays/red_button.tscn")
@onready var blueButtonScene = preload("res://scenes/SimonSays/blue_button.tscn")
@onready var greenButtonScene = preload("res://scenes/SimonSays/green_button.tscn")
@onready var yellowButtonScene = preload("res://scenes/SimonSays/yellow_button.tscn")







# Called when the node enters the scene tree for the first time.
func _ready():

	_initialize_buttons()
	_game_initialize()

	
func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)


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
	GameManager.set_gameover_panel(true)
	GameManager.check_highscore_and_rank("simon_says")
	_set_buttons_disabled(true)
	GameManager.reset_score()
	GameManager.set_game_enabled(false)
	computerPopulate = 0
	arrayOfButtonsToFollow = []
	_stop_game_button_sounds()
	_stop_game_button_animations_and_timer()
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1
	
func _initialize_buttons():
	var buttonScenes = [
		redButtonScene, blueButtonScene, greenButtonScene, yellowButtonScene
	]

	for node in get_tree().get_nodes_in_group("simonSaysGameButtons"):
		node.remove_from_group("simonSaysGameButtons")
	var playAreaPosition = GameManager.get_play_area_position_from_HUD()
	var playAreaSize = GameManager.get_play_area_size_from_HUD()
	var totalButtons = buttonScenes.size()

	# Calculate the position to center the buttons
	var centerPosX = (playAreaSize.x/2+playAreaPosition.x)
	var centerPosY = (playAreaSize.y/2+playAreaPosition.y)

	# Calculate the total width and height occupied by buttons
	var totalWidth = playAreaSize.x/2
	var totalHeight = playAreaSize.y/2

	# Calculate the starting position for the first button


	for i in range(totalButtons):

		# Calculate the position with proper spacing
		var col = i % 2
		var row = i / 2
		var button = buttonScenes[i].instantiate()
		var startX = centerPosX - button.size.x 
		var startY = centerPosY - button.size.y
		print(col,row)
		button.position = Vector2(
			startX + col * button.size.x,
			startY + row * button.size.y
		)
		button.buttonNumber = i
		button.game_button_pressed.connect(_on_game_button_pressed)
		button.add_to_group("simonSaysGameButtons")
		add_child(button)
		buttonObject[button.name] = button
		button.disabled = true


	groupOfButtons = get_tree().get_nodes_in_group("simonSaysGameButtons")
	
func _computer_turn_start():
	_set_buttons_disabled(true)
	_add_next_value()
	$PlaybackTimer.start()
		
func _set_buttons_disabled(setting):

	for i in len(groupOfButtons):
		groupOfButtons[i].disabled = setting

func _stop_all_animations():
	for i in len(groupOfButtonAnimations):
		groupOfButtonAnimations[i].pause()

func _player_turn_end():
	GameManager.update_score(score_value)
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1

func _get_next_value():
	buttonToAdd = floor(rng.randf_range(0, 4))
	return buttonToAdd
	
func _add_next_value():
	arrayOfButtonsToFollow.append(_get_next_value())
	pass # Replace with function body.
	
func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	_computer_turn_start()

	pass # Replace with function body.
	
func _on_playback_timer_timeout():
	groupOfButtons[arrayOfButtonsToFollow[computerPopulate]]._pressed()
	computerPopulate+=1
	if(computerPopulate == len(arrayOfButtonsToFollow)):
		playerTurn = true

		computerPopulate = 0
		_set_buttons_disabled(false)
		$PlaybackTimer.stop()
		
	pass # Replace with function body.

func _stop_game_button_sounds():
	for button in groupOfButtons:
		button.sound.stop()

func _stop_game_button_animations_and_timer():
	for button in groupOfButtons:
		button.faceAnimation.stop()
	for button in groupOfButtons:
		button.faceAnimation.play('default')
	for button in groupOfButtons:
		button.animation.play('dark')
	for button in groupOfButtons:
		button.animationTimer.stop()
	$PlaybackTimer.stop()
	



func _on_game_button_pressed(which):
	if(playerTurn):
		arrayOfPlayerResponse.append(which.buttonNumber)
		playerPopulate += 1
