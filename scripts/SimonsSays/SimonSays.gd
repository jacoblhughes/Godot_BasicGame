extends Node2D

var config = ConfigFile.new()
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
var originalGameButtonY = 288

var redButton
var blueButton
var greenButton
var yellowButton

var high_scores_for_popup
var high_scores_names
var high_scores
var section_name = "SimonSays"
var signalEmitted = false
@onready var redButtonScene = preload("res://scenes/SimonSays/RedButton.tscn")
@onready var blueButtonScene = preload("res://scenes/SimonSays/BlueButton.tscn")
@onready var greenButtonScene = preload("res://scenes/SimonSays/GreenButton.tscn")
@onready var yellowButtonScene = preload("res://scenes/SimonSays/YellowButton.tscn")

@onready var err = config.load("res://data/ConfigFile.cfg")
@onready var currentInitials = HUDVariables.get_initials_from_HUD()

@onready var HUDSIGNALS = get_tree().get_root().get_node("Main").get_node("HUD_SCENE")


# Called when the node enters the scene tree for the first time.
func _ready():
	initializeButtons()
	HUDSIGNALS.startButtonPressed.connect(_on_play_button_pressed)
	HUDSIGNALS.resetButtonPressed.connect(on_reset_button_reset_button_pressed)
	groupOfButtons = get_tree().get_nodes_in_group("simonSaysGameButtons")#
	update_score(gameScore)
	high_scores_names = config.get_value(section_name, "names", [])
	high_scores = config.get_value(section_name, "scores", [])
#	var item_list = $HighScorePopup/ColorRect/ItemList
	if high_scores_names.size() != high_scores.size():
		print("Error: Names and scores arrays have different sizes.")
		return
#	for i in range(high_scores_names.size()):
#		var name = high_scores_names[i]
#		var score = high_scores[i]
#		var displayText = name + ": " + str(score)  # Format as needed
#
#		item_list.add_item(displayText)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
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
	
	var added = false

	for i in range(high_scores.size()):
		if gameScore > high_scores[i]:
			high_scores.insert(i, gameScore)
			high_scores_names.insert(i, currentInitials)
			added = true
			break

	if not added and high_scores.size() < 10:
		high_scores.append(gameScore)
		high_scores_names.append(currentInitials)

	while high_scores.size() > 10:
		high_scores.remove_at(high_scores.size() - 1)
		high_scores_names.remove_at(high_scores_names.size() - 1)



	config.save("res://data/ConfigFile.cfg")
	_stop_game_button_sounds()
	_stop_game_button_animations_and_timer()
	$PlaybackTimer.stop()
	if(added):
		HUDVariables.play_applause()
	else:
		HUDVariables.play_game_over()
	
	_change_game_disabled(true)
	gameScore = 0
	update_score(gameScore)
	gameInitialized = false
	gameRunning = false
	computerPopulate = 0
	arrayOfButtonsToFollow = []

	_player_turn_end()
	update_status("LOSER")

func initializeButtons():
	var buttonScenes = [
		redButtonScene,blueButtonScene,greenButtonScene,yellowButtonScene
	]

	for i in range(buttonScenes.size()):
		var button = buttonScenes[i].instantiate()
		button.position = Vector2(originalGameButtonX + (i % 2) * gameButtonDim, originalGameButtonY + (i / 2) * gameButtonDim)
		button.buttonNumber = i
		button.game_button_pressed.connect(_on_game_button_pressed)
		button.add_to_group("simonSaysGameButtons")
		add_child(button)
		buttonObject[button.name] = button
		button.disabled = true

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
		
		update_score(1)
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1

func update_status(status):
	
#	HUDVariables.set_new_status(status)
	pass

func _get_next_value():
	
	buttonToAdd = floor(rng.randf_range(0, 4))
	return buttonToAdd
	
func _add_next_value():
	
	arrayOfButtonsToFollow.append(_get_next_value())

	pass # Replace with function body.

func update_score(numbah):
	
	HUDVariables.set_new_score(numbah)

func _on_play_button_pressed():


	if(gameInitialized == false and gameRunning == false):
		gameInitialized = true
		gameRunning = true
		_computer_turn_start()
	print('wow')
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

func on_reset_button_reset_button_pressed():
	
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
