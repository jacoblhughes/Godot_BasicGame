extends Control
var config = ConfigFile.new()

var InitialsInput : LineEdit
var game_key
@export var perry_says: PackedScene
var perry_says_scene
@export var perry_python: PackedScene
var perry_python_scene
@export var perry_polo: PackedScene
var perry_polo_scene
@export var perry_llama: PackedScene
var perry_llama_scene
@export var perry_dodge: PackedScene
var perry_dodge_scene
@export var perry_flap: PackedScene
var perry_flap_scene
@export var perry_run: PackedScene
var perry_run_scene
@export var perry_space: PackedScene
var perry_space_scene


@export var about: PackedScene
var about_scene
@export var options: PackedScene
var options_scene
@export var highscore: PackedScene
var highscore_scene

@onready var config_file_path = GameManager.get_config_path_file()
@onready var game_scene : Control
# Called when the node enters the scene tree for the first time.
func _ready():

	InitialsInput = $Initials
	InitialsInput.text = GameManager.get_initials()
	game_scene = get_tree().get_root().get_node("Main").get_node("AspectRatioContainer").get_node("Control").get_node("GameScene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_initials_text_changed(new_text):

	GameManager.set_initials(new_text)
	pass # Replace with function body.

func _on_simon_says_pressed():
	self.visible = false
	game_key = "1"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_says_scene = perry_says.instantiate()
	game_scene.add_child(perry_says_scene)
	GameManager.set_current_game_scene(perry_says)
	pass # Replace with function body.
	
func _on_snake_pressed():
	self.visible = false
	game_key = "2"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_python_scene = perry_python.instantiate()
	game_scene.add_child(perry_python_scene)
	GameManager.set_current_game_scene(perry_python)
	pass # Replace with function body.

func _on_pong_pressed():
	self.visible = false
	game_key = "3"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_polo_scene = perry_polo.instantiate()
	game_scene.add_child(perry_polo_scene)
	GameManager.set_current_game_scene(perry_polo)
	pass # Replace with function body.

func _on_dino_pressed():
	self.visible = false
	game_key = "4"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_llama_scene = perry_llama.instantiate()
	game_scene.add_child(perry_llama_scene)
	GameManager.set_current_game_scene(perry_llama)
	pass # Replace with function body.


func _on_creep_pressed():
	self.visible = false
	game_key = "5"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_dodge_scene = perry_dodge.instantiate()
	game_scene.add_child(perry_dodge_scene)
	GameManager.set_current_game_scene(perry_dodge)
	pass # Replace with function body.


func _on_flappy_pressed():
	self.visible = false
	game_key = "6"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_flap_scene = perry_flap.instantiate()
	game_scene.add_child(perry_flap_scene)
	GameManager.set_current_game_scene(perry_flap)
	pass # Replace with function body.


func _on_saucer_pressed():
	self.visible = false
	game_key = "7"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_run_scene = perry_run.instantiate()
	game_scene.add_child(perry_run_scene)
	GameManager.set_current_game_scene(perry_run)
	pass # Replace with function body.


func _on_perry_space_pressed():
	self.visible = false
	game_key = "8"
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameManager.set_gamestartpanel(true)
	GameManager.set_title(title)
	GameManager.set_directions(directions)
	GameManager.set_game_key(game_key)
	perry_space_scene = perry_space.instantiate()
	game_scene.add_child(perry_space_scene)
	GameManager.set_current_game_scene(perry_space)
	pass # Replace with function body.



func _on_about_pressed():
	self.visible = false

	about_scene = about.instantiate()
	game_scene.add_child(about_scene)
	GameManager.set_current_game_scene(about)
	pass # Replace with function body.


func _on_options_pressed():
	self.visible = false

	options_scene = options.instantiate()
	game_scene.add_child(options_scene)
	GameManager.set_current_game_scene(options)
	pass # Replace with function body.


func _on_highscore_pressed():
	self.visible = false

	highscore_scene = highscore.instantiate()
	game_scene.add_child(highscore_scene)
	GameManager.set_current_game_scene(highscore)
	pass # Replace with function body.
