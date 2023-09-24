extends Node

var arrayOfPlayerResponse = []
var arrayOfButtonsToFollow = []
var objectOfButtonsForMapping = {}
var buttonToAdd = 0
var rng = RandomNumberGenerator.new()
var gameDisabled=true
var groupOfButtons
var groupOfButtonAnimations
var disabledColor
var gameScore = 0
var gameInitialized = false
var gameRunning = false
var playerTurn = false
var computerPopulate = 0
var playerPopulate = -1
var button_pressed
var buttonObject = {}
var simonButtons = 4
var gameButtonDim = 96*2

var originalGameButtonX = 168
var originalGameButtonY = 320

var redButton
var blueButton
var greenButton
var yellowButton

@onready var redButtonScene = preload("res://scenes/SimonSays/RedButton.tscn")
@onready var blueButtonScene = preload("res://scenes/SimonSays/BlueButton.tscn")
@onready var greenButtonScene = preload("res://scenes/SimonSays/GreenButton.tscn")
@onready var yellowButtonScene = preload("res://scenes/SimonSays/YellowButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	redButton = redButtonScene.instantiate()
	blueButton = blueButtonScene.instantiate()
	greenButton = greenButtonScene.instantiate()
	yellowButton = yellowButtonScene.instantiate()
	redButton.position = Vector2(originalGameButtonX,originalGameButtonY)
	redButton.buttonNumber = 0
	blueButton.position = Vector2(originalGameButtonX + gameButtonDim,originalGameButtonY)
	blueButton.buttonNumber = 1
	greenButton.position = Vector2(originalGameButtonX,originalGameButtonY + gameButtonDim)
	greenButton.buttonNumber = 2
	yellowButton.position = Vector2(originalGameButtonX + gameButtonDim,originalGameButtonY + gameButtonDim)
	yellowButton.buttonNumber = 3
	redButton.game_button_pressed.connect(_on_game_button_pressed)
	blueButton.game_button_pressed.connect(_on_game_button_pressed)
	greenButton.game_button_pressed.connect(_on_game_button_pressed)
	yellowButton.game_button_pressed.connect(_on_game_button_pressed)
	add_child(redButton)
	add_child(blueButton)
	add_child(greenButton)
	add_child(yellowButton)
	
	redButton.add_to_group("simonSaysGameButtons")
	blueButton.add_to_group("simonSaysGameButtons")
	greenButton.add_to_group("simonSaysGameButtons")
	yellowButton.add_to_group("simonSaysGameButtons")
	groupOfButtons = get_tree().get_nodes_in_group("simonSaysGameButtons")
	
	for button in groupOfButtons:

		buttonObject[button.name] = button
		button.disabled = true
#
	update_score(gameScore)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(playerTurn):

		if(len(arrayOfPlayerResponse)>0):
			if(arrayOfButtonsToFollow[playerPopulate] == arrayOfPlayerResponse[playerPopulate]):
				if(len(arrayOfButtonsToFollow) == len(arrayOfPlayerResponse)):
					_change_game_disabled(true)
					_player_turn_end()
					_computer_turn_start()
			else:
				_game_lose()
			
	pass

func _game_lose():
	
	_stop_game_button_sounds()
	_stop_game_button_animations_and_timer()
	$PlaybackTimer.stop()
	
	$Aww_Sound.play()
	
	_change_game_disabled(true)
	gameScore = 0
	update_score(gameScore)
	gameInitialized = false
	gameRunning = false
	computerPopulate = 0
	arrayOfButtonsToFollow = []

	_player_turn_end()
	update_status("LOSER")



func _computer_turn_start():
	
	update_status("Computer Turn")
	_change_game_disabled(true)
	_add_next_value()
	if(gameRunning == true):
		$PlaybackTimer.start()
		
func _change_game_disabled(setting):
	
	gameDisabled = setting
	for i in len(groupOfButtons):
		groupOfButtons[i].disabled = gameDisabled

func _stop_all_animations():
	
	for i in len(groupOfButtonAnimations):
		groupOfButtonAnimations[i].pause()

func _player_turn_end():
	
	if(gameRunning==true):
		gameScore +=1
		update_score(gameScore)
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1

func update_status(status):
	
	$"GameStatus".text = status

func _get_next_value():
	
	buttonToAdd = floor(rng.randf_range(0, 4))
	return buttonToAdd
	
func _add_next_value():
	
	arrayOfButtonsToFollow.append(_get_next_value())

	pass # Replace with function body.

func update_score(numbah):
	
	$Score.text = str(gameScore)

func _play_button_pressed():
	
	if(gameInitialized == false and gameRunning == false):
		gameInitialized = true
		gameRunning = true
		_computer_turn_start()

	pass # Replace with function body.
	
func _on_playback_timer_timeout():
	
	groupOfButtons[arrayOfButtonsToFollow[computerPopulate]]._pressed()
	computerPopulate+=1
	if(computerPopulate == len(arrayOfButtonsToFollow)):
		playerTurn = true
		update_status("Player Turn")
		computerPopulate = 0
		_change_game_disabled(false)
		$PlaybackTimer.stop()
		
	pass # Replace with function body.

func _stop_game_button_sounds():
	
	for button in groupOfButtons:
		button.sound.stop()

func _stop_game_button_animations_and_timer():
	
	for button in groupOfButtons:
		button.faceAnimation.stop()
	for button in groupOfButtons:
		button.faceAnimation.play('resting')
	for button in groupOfButtons:
		button.animation.play('dark')
	for button in groupOfButtons:
		button.animationTimer.stop()

func _on_reset_button_reset_button_pressed():
	
	_stop_game_button_sounds()
	_stop_game_button_animations_and_timer()
	$PlaybackTimer.stop()	
	_change_game_disabled(true)
	gameScore = 0
	gameInitialized = false
	gameRunning = false
	computerPopulate = 0
	arrayOfButtonsToFollow = []
	update_score(gameScore)
	_player_turn_end()
	update_status("RESET")
	
	pass # Replace with function body.

func _on_test_pressed():
	
	_change_game_disabled(false)
	
	pass # Replace with function body.

func _on_game_button_pressed(which):
	
	if(playerTurn):
		arrayOfPlayerResponse.append(which.buttonNumber)
		playerPopulate += 1
		
	pass
