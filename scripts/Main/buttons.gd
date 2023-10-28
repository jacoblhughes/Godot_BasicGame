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

# Called when the node enters the scene tree for the first time.
func _ready():

	InitialsInput = $Initials
	InitialsInput.text = GameManager.get_initials()
	
	HighscorePopup = $HighScorePopup
	HighscorePopupList = $HighScorePopup/ItemList
	

#	GameStartPanel = $Control/GameStartPanel

	GameManager.initiate_highscores_section('simon_says')
	GameManager.initiate_highscores_section('snake')
	# Get data for SimonSays
	var simon_says_names = GameManager.get_highscore_names('simon_says')
	var simon_says_scores = GameManager.get_highscore_scores('simon_says')

	# Get data for Snake
	var snake_names = GameManager.get_highscore_names('snake')
	var snake_scores = GameManager.get_highscore_scores('snake')

	

# Add a header for clarity
	HighscorePopupList.add_item("--- SimonSays Scores ---")
	for i in range(simon_says_names.size()):
		HighscorePopupList.add_item(simon_says_names[i] + ": " + str(simon_says_scores[i]))

	# Another header for Snake scores
	HighscorePopupList.add_item("--- Snake Scores ---")
	for i in range(snake_names.size()):
		HighscorePopupList.add_item(snake_names[i] + ": " + str(snake_scores[i]))
		
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
	GameManager.set_directions("Press the buttons in the same order that the computer provides!")
	simon_says_scene = simon_says.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(simon_says_scene)
	GameManager.set_current_game_scene(simon_says)
	pass # Replace with function body.
	
func _on_snake_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('S-S-S-Snake')
	GameManager.set_directions("Press the buttons in the same order that the computer provides!")
	snake_scene = snake.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(snake_scene)
	pass # Replace with function body.

func _on_pong_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Pong')
	GameManager.set_directions("Get to 11 to go to the next level. If the computer scores, you lose a point! After hitting play, click to start the balls motion.")
	pong_scene = pong.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(pong_scene)
	GameManager.set_current_game_scene(pong)
	pass # Replace with function body.

func _on_dino_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Dino')
	GameManager.set_directions("Perry is an evil wizard casting spells against the friendly llama! Help the llama avoid the pain by jumping over the enemies!")
	dino_scene = dino.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(dino_scene)
	pass # Replace with function body.


func _on_creep_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Simon Says')
	GameManager.set_directions("Press the buttons in the same order that the computer provides!")
	creep_scene = creep.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(creep_scene)
	pass # Replace with function body.


func _on_flappy_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Simon Says')
	GameManager.set_directions("Press the buttons in the same order that the computer provides!")
	flappy_scene = flappy.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(flappy_scene)
	pass # Replace with function body.


func _on_saucer_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Simon Says')
	GameManager.set_directions("Press the buttons in the same order that the computer provides!")
	saucer_scene = saucer.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(saucer_scene)
	pass # Replace with function body.


func _on_attack_pressed():
	self.visible = false
	GameManager.set_gamestartpanel(true)
	GameManager.set_title('Simon Says')
	GameManager.set_directions("Press the buttons in the same order that the computer provides!")
	attack_scene = attack.instantiate()
	get_tree().get_root().get_node("Main").get_node("GameScene").add_child(attack_scene)
	pass # Replace with function body.

