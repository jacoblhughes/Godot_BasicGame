extends Node

var config = ConfigFile.new()
var section_name = "highscores"
var section_key = "initials"
@onready var err = config.load("res://data/SimonSays/SimonSays.cfg")
@onready var new_initials = config.get_value(section_name, section_key)



# Called when the node enters the scene tree for the first time.
func _ready():
	print(new_initials)
	set_initials(new_initials)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_initials(initials):
	new_initials = initials

func get_initials():
	return new_initials
