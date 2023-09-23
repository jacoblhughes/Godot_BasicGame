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


# Called when the node enters the scene tree for the first time.
func _on_ready():
	groupOfButtons = get_tree().get_nodes_in_group("simonSaysGameButtons")
	groupOfButtonAnimations = get_tree().get_nodes_in_group("simonSaysGameButtonAnimations")
	for i in len(groupOfButtons):
		print(i, ' is i')
		objectOfButtonsForMapping[i]=groupOfButtons[i]
		groupOfButtons[i].disabled = gameDisabled
		
	update_score(gameScore)
	print(objectOfButtonsForMapping)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(playerTurn):
		print(playerPopulate+1)
		print(arrayOfButtonsToFollow)
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
	_change_game_disabled(true)
	gameScore = 0
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
	update_score(1)
	playerTurn = false
	arrayOfPlayerResponse = []
	playerPopulate = -1

func update_status(status):
	$"GameStatus".text = status

func _on_button_first_pressed():

#	$Button_First/Button_First_Animation.play("default")
#	$Button_First/Button_First_Sound.play()
#	$AnimationTimer.start()
#	if(playerTurn):
#		arrayOfPlayerResponse.append(0)
#		playerPopulate += 1
	pass # Replace with function body.


func _on_button_second_pressed():

#	$Button_Second/Button_Second_Sound.play()
#	$Button_Second/Button_Second_Animation.play("default")
#	$AnimationTimer.start()
#	if(playerTurn):
#		arrayOfPlayerResponse.append(1)
#		playerPopulate += 1
	pass # Replace with function body.


func _on_button_third_pressed():
#	$Button_Third/Button_Third_Animation.play("default")
#	$Button_Third/Button_Third_Sound.play()
#	$AnimationTimer.start()
#	if(playerTurn):
#		arrayOfPlayerResponse.append(2)
#		playerPopulate += 1
	pass # Replace with function body.


func _on_button_fourth_pressed():
#	$Button_Fourth/Button_Fourth_Sound.play()
#	$Button_Fourth/Button_Fourth_Animation.play("default")
#	$AnimationTimer.start()
#	if(playerTurn):
#		arrayOfPlayerResponse.append(3)
#		playerPopulate += 1
	pass # Replace with function body.

func _get_next_value():
	buttonToAdd = floor(rng.randf_range(0, 4))
	return buttonToAdd
	
func _add_next_value():
	arrayOfButtonsToFollow.append(_get_next_value())

	pass # Replace with function body.

func update_score(numbah):
	gameScore += numbah
	$ScoreLabel.text = str(gameScore)

func _ready():
	pass # Replace with function body.


func _play_button_pressed():
	print('heeeeeee')
	if(gameInitialized == false and gameRunning == false):
		print('eeeee')
		gameInitialized = !gameInitialized
		gameRunning = !gameRunning
		
		_computer_turn_start()
	
	pass # Replace with function body.
	
func _on_playback_timer_timeout():

	groupOfButtons[arrayOfButtonsToFollow[computerPopulate]].emit_signal("button_down")

	computerPopulate+=1

	if(computerPopulate == len(arrayOfButtonsToFollow)):

		playerTurn = true
		update_status("Player Turn")
		computerPopulate = 0
		_change_game_disabled(false)
		$PlaybackTimer.stop()
	pass # Replace with function body.


func _on_animation_timer_timeout():
	$Button_First/Button_First_Animation.stop()
	$Button_Second/Button_Second_Animation.stop()
	$Button_Third/Button_Third_Animation.stop()
	$Button_Fourth/Button_Fourth_Animation.stop()
	
	$Button_First/Button_First_Animation.play("resting")
	$Button_Second/Button_Second_Animation.play("resting")
	$Button_Third/Button_Third_Animation.play("resting")
	$Button_Fourth/Button_Fourth_Animation.play("resting")
	pass # Replace with function body.


func _on_button_first_button_down():
	
	$Button_First/Button_First_Animation.play("default")
	$Button_First/Button_First_Sound.play()
	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(0)
		playerPopulate += 1
	pass # Replace with function body.
	
	pass # Replace with function body.


func _on_button_second_button_down():
	
	$Button_Second/Button_Second_Sound.play()
	$Button_Second/Button_Second_Animation.play("default")
	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(1)
		playerPopulate += 1
	
	pass # Replace with function body.


func _on_button_third_button_down():
	$Button_Third/Button_Third_Animation.play("default")
	$Button_Third/Button_Third_Sound.play()
	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(2)
		playerPopulate += 1
	pass # Replace with function body.


func _on_button_fourth_button_down():
	$Button_Fourth/Button_Fourth_Sound.play()
	$Button_Fourth/Button_Fourth_Animation.play("default")
	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(3)
		playerPopulate += 1
	
	pass # Replace with function body.
