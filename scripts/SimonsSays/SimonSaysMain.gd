extends Node

var arrayToPopulate = []
var buttonToAdd = 0
var rng = RandomNumberGenerator.new()
var gameDisabled=true
var GroupOfButtons


# Called when the node enters the scene tree for the first time.
func _ready():
	GroupOfButtons = get_tree().get_nodes_in_group("SimonSaysGameButtons")


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_button_first_pressed():
	print('first')
	pass # Replace with function body.


func _on_button_second_pressed():
	print('second')
	pass # Replace with function body.


func _on_button_third_pressed():
	print('third')
	pass # Replace with function body.


func _on_button_fourth_pressed():
	print('fouth')
	pass # Replace with function body.

func _get_next_value():
	buttonToAdd = ceil(rng.randf_range(0, 4))
	return buttonToAdd
	
func _add_next_value():
	print('no')


func _on_button_first_ready(which):
	print('first button ready')
	print(which.get_name())
	pass # Replace with function body.
