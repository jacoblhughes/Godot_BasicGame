extends Node

var arrayToPopulate = []
var arrayOfButtonsToFollow = []
var objectOfButtonsForMapping = {}
var buttonToAdd = 0
var rng = RandomNumberGenerator.new()
var gameDisabled=true
var groupOfButtons
var disabledColor
var gameScore = 0
var gameRunning = false
var playerTurn = false
var currentPopulate = 0



# Called when the node enters the scene tree for the first time.
func _on_ready():
	groupOfButtons = get_tree().get_nodes_in_group("simonSaysGameButtons")
	_add_next_value()
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
		for i in len(arrayOfButtonsToFollow):
			if(arrayToPopulate[i] == arrayOfButtonsToFollow[i]):
				if(len(arrayOfButtonsToFollow) == len(arrayOfButtonsToFollow)):
					playerTurn = !playerTurn
			else:
				$Aww_Sound.play()
	
	pass


func _on_button_first_pressed():
	$Button_First/Button_First_Sound.play()
	if(playerTurn):
		arrayOfButtonsToFollow.append(0)
	pass # Replace with function body.


func _on_button_second_pressed():
	$Button_Second/Button_Second_Sound.play()
	if(playerTurn):
		arrayOfButtonsToFollow.append(1)
	pass # Replace with function body.


func _on_button_third_pressed():

	$Button_Third/Button_Third_Sound.play()
	if(playerTurn):
		arrayOfButtonsToFollow.append(2)
	pass # Replace with function body.


func _on_button_fourth_pressed():
	$Button_Fourth/Button_Fourth_Sound.play()
	if(playerTurn):
		arrayOfButtonsToFollow.append(3)
	pass # Replace with function body.

func _get_next_value():
	buttonToAdd = floor(rng.randf_range(0, 4))
	return buttonToAdd
	
func _add_next_value():
	arrayToPopulate.append(_get_next_value())

	pass # Replace with function body.

func update_score(gameScore):
	$ScoreLabel.text = str(gameScore)

func _ready():
	pass # Replace with function body.


func _play_button_pressed():
	gameDisabled = !gameDisabled
	if(gameRunning == false):
		$PlaybackTimer.start()
		print(arrayToPopulate)
	for i in len(groupOfButtons):
		groupOfButtons[i].disabled = gameDisabled
	pass # Replace with function body.
	
func _on_playback_timer_timeout():
	groupOfButtons[arrayToPopulate[currentPopulate]].emit_signal("pressed")
	currentPopulate+=1
	if(currentPopulate == len(arrayToPopulate)):
		$PlaybackTimer.stop()
		playerTurn = true
		currentPopulate = 0
	pass # Replace with function body.
