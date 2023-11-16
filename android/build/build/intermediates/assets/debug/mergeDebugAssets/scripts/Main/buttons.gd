extends Control
var config = ConfigFile.new()

var InitialsInput : LineEdit

@export var simon_says: PackedScene
var simon_says_scene
@export var snake: PackedScene
var snake_scene
@export var pong: PackedScene
var pong_scene
@export var dino: PackedScene
var dino_scene
@export var creep: PackedScene
var creep_scene
@export var flappy: PackedScene
var flappy_scene
@export var saucer: PackedScene
var saucer_scene
@export var attack: PackedScene
var attack_scene
@onready var HighscorePopup : Window
@onready var HighscorePopupList : ItemList
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
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Simon Says')
	GameManager.set_directions("Smash Roddy in the right order to get the high score!")
	simon_says_scene = simon_says.instantiate()
	game_scene.add_child(simon_says_scene)
	GameManager.set_current_game_scene(simon_says)
	pass # Replace with function body.
	
func _on_snake_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Snake')
	GameManager.set_directions("EAT RODDY!")
	snake_scene = snake.instantiate()
	game_scene.add_child(snake_scene)
	pass # Replace with function body.

func _on_pong_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Pong')
	GameManager.set_directions("Bounce Roddy around to get the highscore!.")
	pong_scene = pong.instantiate()
	game_scene.add_child(pong_scene)
	GameManager.set_current_game_scene(pong)
	pass # Replace with function body.

func _on_dino_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Dino')
	GameManager.set_directions("Perry stole your headband. Jump over his garbage as you chase him down!")
	dino_scene = dino.instantiate()
	game_scene.add_child(dino_scene)
	GameManager.set_current_game_scene(dino)
	pass # Replace with function body.


func _on_creep_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Creep')
	GameManager.set_directions("AVOID RODDY!")
	creep_scene = creep.instantiate()
	game_scene.add_child(creep_scene)
	GameManager.set_current_game_scene(creep)
	pass # Replace with function body.


func _on_flappy_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Flappy')
	GameManager.set_directions("Roddy is trying to stop the bird from getting home. Help flappy!")
	flappy_scene = flappy.instantiate()
	game_scene.add_child(flappy_scene)
	GameManager.set_current_game_scene(flappy)
	pass # Replace with function body.


func _on_saucer_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Saucer')
	GameManager.set_directions("Get to the end of the maze as fast as you can!")
	saucer_scene = saucer.instantiate()
	game_scene.add_child(saucer_scene)
	GameManager.set_current_game_scene(saucer)
	pass # Replace with function body.


func _on_attack_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Attack')
	GameManager.set_directions("Shoot the Roddies to survive!")
	attack_scene = attack.instantiate()
	game_scene.add_child(attack_scene)
	GameManager.set_current_game_scene(attack)
	pass # Replace with function body.

