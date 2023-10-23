extends Node

# Export the NodePath to the player_initials scene
var config = ConfigFile.new()

@onready var InitialsInput : Label
@onready var ScoreLabel : Label
@onready var StatusLabel : Label
@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer
@onready var PlayArea: ColorRect
@onready var GameStartPanel : CanvasLayer
@onready var Title : Label
@onready var Directions : Label
@onready var HighscorePopup : Window
@onready var HighscorePopupList : ItemList
@onready var PlayButton : Button
@onready var ResetButton : Button
@onready var HighscoreButton : Button
@onready var HomeButton : Button
var child_node_to_delete
@onready var err = config.load("res://data/ConfigFile.cfg")
@onready var new_initials = config.get_value("Main", "initials")
@onready var player_initials = get_initials()
@onready var buttons  = get_tree().get_root().get_node("Main").get_node("Buttons")

var score = 0

signal startButtonPressed
signal resetButtonPressed
signal highscoreButtonpressed
signal initialsUpdated
# Called when the node enters the scene tree for the first time.
func _ready():
	set_initials(new_initials)
	HighscorePopup = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("HighScorePopup")
	HighscorePopupList = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("HighScorePopup").get_node("ItemList")

	InitialsInput = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Initials")
	ScoreLabel = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Score")
#	StatusLabel = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStatus")
	GameOverSound = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameOver")
	ApplauseSound = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Applause")
	BackGroundMusic = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("BackGroundMusic")
	PlayArea = get_tree().get_root().get_node("Main").get_node("PlayAreaCanvas").get_node("PlayArea")
	GameStartPanel = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStartPanel")
	Title = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStartPanel").get_node("Panel").get_node("Title")
	Directions = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStartPanel").get_node("Panel").get_node("Directions")
	PlayButton = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStartPanel").get_node("Panel").get_node("Play_Button")

	ResetButton = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Reset_Button")
	HighscoreButton = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Highscore_Button")
	HomeButton = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Home_Button")
	PlayButton.pressed.connect(_on_play_button_pressed)
	ResetButton.pressed.connect(_on_reset_button_pressed)
	HighscoreButton.pressed.connect(_on_highscore_pressed)
	HomeButton.pressed.connect(_on_home_button_pressed)
func set_new_score(new_score):
		if new_score == 0:
			score = 0
			var this_score = str(score)
			ScoreLabel.text = this_score
		else:
			score += new_score
			var this_score = str(score)
			ScoreLabel.text = this_score
		
#func set_new_status(status):
#		StatusLabel.text = status

func play_game_over():
	GameOverSound.play()

func play_applause():
	ApplauseSound.play()
	
func get_initials_from_HUD() -> String:
	return InitialsInput.text

func get_play_area_size_from_HUD():
	return PlayArea.size
	
func get_play_area_position_from_HUD():
	return PlayArea.position

func get_current_score():
	return ScoreLabel.text

func set_gamestartpanel(vis):
	GameStartPanel.visible = vis
	
func set_title(title):
	Title.text=title

func set_directions(directions):
	Directions.text = directions
	




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
	GameStartPanel.visible = false
	startButtonPressed.emit()
	pass # Replace with function body.


func _on_reset_button_pressed():

	resetButtonPressed.emit()
	pass # Replace with function body.

func _on_highscore_pressed():
	highscoreButtonpressed.emit()
	HighscorePopup.visible = !HighscorePopup.visible
	pass # Replace with function body.

func set_initials(initials):
	new_initials = initials

func get_initials():
	return new_initials

