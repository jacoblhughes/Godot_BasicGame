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
@onready var config_file_path = config.load("res://data/ConfigFile.cfg")
@onready var new_initials = config.get_value("main", "initials")
@onready var game_over_panel : CanvasLayer
@onready var buttons_scene  = get_tree().get_root().get_node("Main").get_node("Buttons")
@onready var reset_button_from_gameover : Button
@onready var home_button_from_gameover : Button
@onready var game_scene : Node
var score = 0
var game_enabled = false
var current_game_scene : PackedScene

signal startButtonPressed
signal resetButtonPressed
signal highscoreButtonpressed
signal initialsUpdated
# Called when the node enters the scene tree for the first time.
func _ready():


	HighscorePopup = get_tree().get_root().get_node("Main").get_node("Buttons").get_node("HighScorePopup")
	HighscorePopupList = get_tree().get_root().get_node("Main").get_node("Buttons").get_node("HighScorePopup").get_node("ItemList")

	InitialsInput = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("Initials")
	ScoreLabel = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("Score")
#	StatusLabel = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStatus")
	
	GameOverSound = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameOver")
	ApplauseSound = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("Applause")
	BackGroundMusic = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("BackGroundMusic")
	
	PlayArea = get_tree().get_root().get_node("Main").get_node("PlayAreaCanvas").get_node("PlayArea")
	GameStartPanel = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameStartPanel")
	Title = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameStartPanel").get_node("Panel").get_node("Title")
	Directions = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameStartPanel").get_node("Panel").get_node("Directions")
	PlayButton = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameStartPanel").get_node("Panel").get_node("Play_Button")
	game_over_panel = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameOverPanel")
	reset_button_from_gameover = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameOverPanel").get_node("GameOverPanel").get_node("ResetButton")
	home_button_from_gameover = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameOverPanel").get_node("GameOverPanel").get_node("HomeButtonOnGameover")

	HighscoreButton = get_tree().get_root().get_node("Main").get_node("Buttons").get_node("Highscore_Button")
	HomeButton = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("Home_Button")
	
	game_scene = get_tree().get_root().get_node("Main").get_node("GameScene")
	
	PlayButton.pressed.connect(_on_play_button_pressed)

	HighscoreButton.pressed.connect(_on_highscore_pressed)
	HomeButton.pressed.connect(_on_home_button_pressed)
	reset_button_from_gameover.pressed.connect(_on_reset_button_pressed)
	home_button_from_gameover.pressed.connect(_on_home_button_pressed)
	
func set_new_score(new_score):
			score = new_score
			var this_score = str(score)
			ScoreLabel.text = this_score
func update_score(new_score):
			score += new_score
			var this_score = str(score)
			ScoreLabel.text = this_score
		
func reset_score():
	score=0
	ScoreLabel.text = str(score)
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

func get_score():
	return score

func set_gamestartpanel(vis):
	GameStartPanel.visible = vis
	
func set_title(title):
	Title.text=title

func set_directions(directions):
	Directions.text = directions

func _on_home_button_pressed():
	set_gameover_panel(false)
	child_node_to_delete = game_scene.get_children()
	if child_node_to_delete:
		buttons_scene.visible = true
		for child in child_node_to_delete:
			child.queue_free()
	pass # Replace with function body.
	
func _on_play_button_pressed():
	GameStartPanel.visible = false
	startButtonPressed.emit()
	pass # Replace with function body.

func set_gameover_panel(vis):
	game_over_panel.visible = vis

func _on_reset_button_pressed():
	set_gameover_panel(false)
	resetButtonPressed.emit()
	child_node_to_delete = game_scene.get_children()
	if child_node_to_delete:
		for child in child_node_to_delete:
			child.queue_free()
	set_game_again()
	pass # Replace with function body.
func set_game_again():
	game_scene.add_child(current_game_scene.instantiate(),true)
	GameManager.set_gamestartpanel(true)

func _on_highscore_pressed():
	highscoreButtonpressed.emit()
	HighscorePopup.visible = !HighscorePopup.visible
	pass # Replace with function body.

func load_initials():
	InitialsInput.text = new_initials

func set_initials(initials):
	new_initials = initials
	InitialsInput.text = new_initials

func get_initials():
	return new_initials

func check_highscore_and_rank(section_name):

	var high_scores_names = config.get_value(section_name, "names", [])
	var high_scores = config.get_value(section_name, "scores", [])
#	var item_list = $HighScorePopup/ColorRect/ItemList
	if high_scores_names.size() != high_scores.size():
		print("Error: Names and scores arrays have different sizes.")
		return
	
	var added = false

	for i in range(high_scores.size()):
		if score > high_scores[i]:
			print(i)
			print(high_scores[i])
			high_scores.insert(i, score)
			high_scores_names.insert(i, new_initials)
			added = true
			break

	if not added and high_scores.size() < 10:
		high_scores.append(score)
		high_scores_names.append(new_initials)

	while high_scores.size() > 10:
		high_scores.remove_at(high_scores.size() - 1)
		high_scores_names.remove_at(high_scores_names.size() - 1)

	config.save("res://data/ConfigFile.cfg")
	print(high_scores)
	print(high_scores_names)

	if(added):
		GameManager.play_applause()
	else:
		GameManager.play_game_over()

func set_current_game_scene(scene):
	current_game_scene = scene

func get_current_game_scene():
	return current_game_scene

func get_game_enabled():
	return game_enabled

func set_game_enabled():
	game_enabled = !game_enabled
