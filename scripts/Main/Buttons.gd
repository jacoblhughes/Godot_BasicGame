extends Control
var config = ConfigFile.new()
var section_name = "Main"
var section_key = "initials"
@onready var err = config.load("res://data/ConfigFile.cfg")
@onready var new_initials = config.get_value(section_name, section_key)

var InitialsInput : LineEdit

@export var simon_says: PackedScene
var simon_says_scene
@export var snake: PackedScene
var snake_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	print(new_initials)
	InitialsInput = $Initials
	InitialsInput.text = new_initials
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_initials_text_changed(new_text):
	config.set_value(section_name, section_key, new_text)
	config.save("res://data/ConfigFile.cfg")
	PlayerVariables.set_initials(new_text)
	pass # Replace with function body.

func _on_simon_says_pressed():
	self.visible = false
	simon_says_scene = simon_says.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(simon_says_scene)
	pass # Replace with function body.
	
func _on_snake_pressed():
	self.visible = false
	snake_scene = snake.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(snake_scene)
	pass # Replace with function body.

