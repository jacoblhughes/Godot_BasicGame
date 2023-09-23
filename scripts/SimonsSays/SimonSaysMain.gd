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



# Called when the node enters the scene tree for the first time.
func _on_ready():
	groupOfButtons = get_tree().get_nodes_in_group("simonSaysGameButtons")
	for button in groupOfButtons:
		print(button.name)
		buttonObject[button.name] = button
		
	groupOfButtonAnimations = get_tree().get_nodes_in_group("simonSaysGameButtonAnimations")
	for i in len(groupOfButtons):

		objectOfButtonsForMapping[i]=groupOfButtons[i]
		groupOfButtons[i].disabled = gameDisabled
		
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
	
	$B1/Face_Animation.stop()
	$B2/Face_Animation.stop()
	$B3/Face_Animation.stop()
	$B4/Face_Animation.stop()
	
	$B1/Button_Animation.play("dark")
	$B2/Button_Animation.play("dark")
	$B3/Button_Animation.play("dark")
	$B4/Button_Animation.play("dark")
	
	$B1/Button_Sound.stop()
	$B2/Button_Sound.stop()
	$B3/Button_Sound.stop()
	$B4/Button_Sound.stop()
	
	$Aww_Sound.play()
	_change_game_disabled(true)
	gameScore = 0
	gameInitialized = false
	gameRunning = false
	computerPopulate = 0
	arrayOfButtonsToFollow = []
	update_score(gameScore)
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

func _on_button_first_pressed():

#	$B1/Face_Animation.play("default")
#	$B1/Button_First_Sound.play()
#	$AnimationTimer.start()
#	if(playerTurn):
#		arrayOfPlayerResponse.append(0)
#		playerPopulate += 1
	pass # Replace with function body.


func _on_button_second_pressed():

#	$B2/Button_Second_Sound.play()
#	$B2/Button_Second_Animation.play("default")
#	$AnimationTimer.start()
#	if(playerTurn):
#		arrayOfPlayerResponse.append(1)
#		playerPopulate += 1
	pass # Replace with function body.


func _on_button_third_pressed():
#	$B3/Button_Third_Animation.play("default")
#	$B3/Button_Third_Sound.play()
#	$AnimationTimer.start()
#	if(playerTurn):
#		arrayOfPlayerResponse.append(2)
#		playerPopulate += 1
	pass # Replace with function body.


func _on_button_fourth_pressed():
#	$B4/Button_Fourth_Sound.play()
#	$B4/Button_Fourth_Animation.play("default")
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
	$Score.text = str(gameScore)

func _ready():
	pass # Replace with function body.


func _play_button_pressed():

	if(gameInitialized == false and gameRunning == false):

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
	$B1/Face_Animation.stop()
	$B2/Face_Animation.stop()
	$B3/Face_Animation.stop()
	$B4/Face_Animation.stop()
	
	$B1/Button_Animation.play("dark")
	$B2/Button_Animation.play("dark")
	$B3/Button_Animation.play("dark")
	$B4/Button_Animation.play("dark")

	$B1/Face_Animation.play("resting")
	$B2/Face_Animation.play("resting")
	$B3/Face_Animation.play("resting")
	$B4/Face_Animation.play("resting")
	pass # Replace with function body.
	

func _on_button_first_button_down(which):
	
	which/Button_Sound.play()
	
	$B1/Button_Sound.play()
	$B1/Face_Animation.play("default")
	$B1/Button_Animation.play("light")
	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(0)
		playerPopulate += 1
	pass # Replace with function body.
	
	pass # Replace with function body.


func _on_button_second_button_down():
	
	$B2/Button_Sound.play()
	$B2/Button_Animation.play("light")
	$B2/Face_Animation.play("default")
	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(1)
		playerPopulate += 1
	
	pass # Replace with function body.


func _on_button_third_button_down():
	
	$B3/Button_Sound.play()
	$B3/Face_Animation.play("default")
	$B3/Button_Animation.play("light")

	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(2)
		playerPopulate += 1
	pass # Replace with function body.


func _on_button_fourth_button_down():
	
	$B4/Button_Sound.play()
	$B4/Face_Animation.play("default")
	$B4/Button_Animation.play("light")
	$AnimationTimer.start()
	if(playerTurn):
		arrayOfPlayerResponse.append(3)
		playerPopulate += 1
	
	pass # Replace with function body.


func _on_button_first_button_up():
	

	pass # Replace with function body.


func _on_button_second_button_up():


	pass # Replace with function body.


func _on_button_third_button_up():


	pass # Replace with function body.


func _on_button_fourth_button_up():
	

	pass # Replace with function body.


func _on_reset_button_reset_button_pressed(which):
	print(which.name)
	
	$PlaybackTimer.stop()
	$AnimationTimer.stop()
	$B1/Face_Animation.stop()
	$B2/Face_Animation.stop()
	$B3/Face_Animation.stop()
	$B4/Face_Animation.stop()
	
	$B1/Button_Animation.play("dark")
	$B2/Button_Animation.play("dark")
	$B3/Button_Animation.play("dark")
	$B4/Button_Animation.play("dark")
	
	$B1/Button_Sound.stop()
	$B2/Button_Sound.stop()
	$B3/Button_Sound.stop()
	$B4/Button_Sound.stop()
	
	$Aww_Sound.play()
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
