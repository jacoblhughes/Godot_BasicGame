extends CanvasLayer
var config = ConfigFile.new()


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
@export var perry_squash: PackedScene
var perry_squash_scene
@export var perry_putt: PackedScene
var perry_putt_scene
@export var perry_test: PackedScene
var perry_test_scene


var main_scene : Node

@export var about: PackedScene
var about_scene
@export var options: PackedScene
var options_scene
@export var highscore: PackedScene
var highscore_scene

@onready var config_file_path = GameManager.get_config_path_file()
# Called when the node enters the scene tree for the first time.
func _ready():

	main_scene = get_tree().get_root().get_node("Main")
	for item in get_tree().get_nodes_in_group("game_button"):
		item.game_chosen.connect(_on_game_chosen)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_game_chosen(game_key,game_scene):
	self.visible = false
	var title = GameManager.get_game_list_values(game_key)["title"]
	var directions = GameManager.get_game_list_values(game_key)["directions"]
	GameStartGameOver.set_game(true,title,directions)
	GameManager.set_game_key(game_key)
	var game_scene_instance = game_scene.instantiate()
	main_scene.add_child(game_scene_instance)
	GameManager.set_current_game_scene(perry_says)

func _on_about_pressed():
	self.visible = false
	about_scene = about.instantiate()
	main_scene.add_child(about_scene)
	GameManager.set_current_game_scene(about)
	pass # Replace with function body.

func _on_options_pressed():
	self.visible = false
	options_scene = options.instantiate()
	main_scene.add_child(options_scene)
	GameManager.set_current_game_scene(options)
	pass # Replace with function body.


func _on_highscore_pressed():
	self.visible = false
	highscore_scene = highscore.instantiate()
	main_scene.add_child(highscore_scene)
	GameManager.set_current_game_scene(highscore)
	pass # Replace with function body.


#func _on_perry_test_pressed():
#	self.visible = false
##	game_key = "10"
##	var title = GameManager.get_game_list_values(game_key)["title"]
##	var directions = GameManager.get_game_list_values(game_key)["directions"]
#	HUD.set_game(true,"test","directions")
##	GameManager.set_game_key(game_key)
#	perry_test_scene = perry_test.instantiate()
#	game_scene.add_child(perry_test_scene)
##	GameManager.set_current_game_scene(perry_putt)
#	pass # Replace with function body.
