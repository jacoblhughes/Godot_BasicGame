extends Control
var config = ConfigFile.new()
var section_name = "highscores"
var section_key = "initials"
@onready var err = config.load("res://data/SimonSays/SimonSays.cfg")
@onready var new_initials = config.get_value(section_name, section_key)


# Called when the node enters the scene tree for the first time.
func _ready():
	print(new_initials)
	$Initials.text = new_initials
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():

	pass # Replace with function body.

func _on_snake_pressed():
	get_tree().change_scene_to_file("res://scenes/Snake/Snake.tscn")
	pass # Replace with function body.


func _on_simonsays_pressed():
	get_tree().change_scene_to_file("res://scenes/SimonSays/SimonSaysGame.tscn")
	pass # Replace with function body.


func _on_initials_text_changed(new_text):
	print('changed')
	print(new_text)
	config.set_value(section_name, section_key, new_text)
	config.save("res://data/SimonSays/SimonSays.cfg")
	pass # Replace with function body.
