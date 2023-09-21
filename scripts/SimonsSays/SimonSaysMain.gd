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
var j



# Called when the node enters the scene tree for the first time.
func _on_ready():
	groupOfButtons = get_tree().get_nodes_in_group("simonSaysGameButtons")
	
#	label.get_stylebox("normal").bg_color = new_color 
	for i in len(groupOfButtons):
		j=i+1
		objectOfButtonsForMapping[j]=groupOfButtons[i]
#		groupOfButtons[i].disabled = gameDisabled
		
	update_score(gameScore)
	print(objectOfButtonsForMapping)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_button_first_pressed():
	print('hee')
#	for child in get_children():
#		print(child)
#		if child is AudioStreamPlayer:
#			child.play()
	pass # Replace with function body.


func _on_button_second_pressed():
	$Button_First/Button_Second_Sound.play()
	print('second')
	pass # Replace with function body.


func _on_button_third_pressed():

	$Button_First/Button_First_Sound.play()
	print('third')
	pass # Replace with function body.


func _on_button_fourth_pressed():
	$Button_First/Button_First_Sound.play()
	print('fouth')
	pass # Replace with function body.

func _get_next_value():
	buttonToAdd = ceil(rng.randf_range(0, 4))
	return buttonToAdd
	
func _add_next_value():
	arrayToPopulate.append(_get_next_value())
	print(arrayToPopulate)
	pass # Replace with function body.

func update_score(gameScore):
	$ScoreLabel.text = str(gameScore)







func _ready():
	pass # Replace with function body.


func _play_button_pressed():
	if(gameRunning == false):
		_add_next_value()
	
		_run_sequence_to_follow()
	
	pass # Replace with function body.

func _run_sequence_to_follow():
	
	pass
