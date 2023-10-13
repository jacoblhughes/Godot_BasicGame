extends CanvasLayer

# Export the NodePath to the player_initials scene
@onready var player_initials = PlayerVariables.get_initials()
@onready var InitialsInput : Label
@onready var ScoreLabel : Label
@onready var StatusLabel : Label
@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer
@onready var HighscorePopup : Window
@onready var HighscorePopupList : ItemList
var child_node_to_delete
var config = ConfigFile.new()
@onready var configFile = config.load("res://data/ConfigFile.cfg")

@onready var buttons  = get_tree().get_root().get_node("Main").get_node("Buttons")
var score = 0

signal startButtonPressed
signal resetButtonPressed
signal highscoreButtonpressed
# Called when the node enters the scene tree for the first time.
func _ready():	
	InitialsInput = $Control/Initials
	ScoreLabel = $Control/Score
	StatusLabel = $Control/GameStatus
	GameOverSound = $Control/GameOver
	ApplauseSound = $Control/Applause
	BackGroundMusic = $Control/BackGroundMusic
	HighscorePopup = $Control/HighScorePopup
	HighscorePopupList = $Control/HighScorePopup/ItemList
	_update_initials_label()
	# Get data for SimonSays
	var simon_names = config.get_value("SimonSays", "names", [])
	var simon_scores = config.get_value("SimonSays", "scores", [])

	# Get data for Snake
	var snake_names = config.get_value("Snake", "names", [])
	var snake_scores = config.get_value("Snake", "scores", [])
	
	

# Add a header for clarity
	HighscorePopupList.add_item("--- SimonSays Scores ---")
	for i in range(simon_names.size()):
		HighscorePopupList.add_item(simon_names[i] + ": " + str(simon_scores[i]))

	# Another header for Snake scores
	HighscorePopupList.add_item("--- Snake Scores ---")
	for i in range(snake_names.size()):
		HighscorePopupList.add_item(snake_names[i] + ": " + str(snake_scores[i]))
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	player_initials = PlayerVariables.get_initials()
	InitialsInput.text = player_initials

func _update_initials_label():

	if player_initials:
		InitialsInput.text = player_initials
	else:
		print("Player initials instance not found or does not have the 'get_initials' function.")


func _on_home_button_pressed():
	
	child_node_to_delete = get_tree().get_root().get_node("Main").get_node("GameScene").get_children()
	if child_node_to_delete:
		buttons.visible = true
		for child in child_node_to_delete:
			child.queue_free()
	pass # Replace with function body.
	
func _on_play_button_pressed():

	startButtonPressed.emit()
	pass # Replace with function body.


func _on_reset_button_pressed():

	resetButtonPressed.emit()
	pass # Replace with function body.

func _on_highscore_pressed():
	highscoreButtonpressed.emit()
	HighscorePopup.visible = !HighscorePopup.visible
	pass # Replace with function body.


