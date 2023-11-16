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
@onready var GameStartPanel : Panel
@onready var Title : Label
@onready var Directions : Label
@onready var high_score_popup : Window
@onready var high_score_popup_list : ItemList
@onready var PlayButton : Button
@onready var ResetButton : Button
@onready var HighscoreButton : Button
@onready var HomeButton : Button
var child_node_to_delete
@onready var config_file_path
@onready var new_initials
@onready var game_over_panel : Panel
@onready var reset_button_from_gameover : Button
@onready var home_button_from_gameover : Button
@onready var game_scene : Node
@onready var lives_label : Label
@onready var aspect_ratio_container
@onready var buttons : Control
@onready var hud_control : Control
var perry_arcade_path = "user://perry_arcade.cfg"
var lives = 3
var score = 0
var game_enabled = false
var current_game_scene : PackedScene

signal startButtonPressed
signal resetButtonPressed
signal highscoreButtonpressed
signal initialsUpdated
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var file_exists = FileAccess.file_exists(perry_arcade_path)
	if(!file_exists):
		var file = FileAccess.open(perry_arcade_path, FileAccess.WRITE_READ)
		file.store_string("[main]\n")
		file.store_string("\n")
		file.store_string("initials=\"JLH\"\n")

	config_file_path = config.load("user://perry_arcade.cfg")
	new_initials = config.get_value("main", "initials")
	aspect_ratio_container = get_tree().get_root().get_node("Main").get_node("AspectRatioContainer").get_node("Control")
	buttons = aspect_ratio_container.get_node("Buttons")
	high_score_popup = buttons.get_node("HighScorePopup")
	high_score_popup_list = high_score_popup.get_node("ItemList")
	hud_control = aspect_ratio_container.get_node("HUD")
	InitialsInput = hud_control.get_node("Initials")
	ScoreLabel = hud_control.get_node("Score")
#	StatusLabel = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStatus")
	
	PlayArea = aspect_ratio_container.get_node("PlayArea")
	GameStartPanel = hud_control.get_node("GameStartPanel")
	Title = hud_control.get_node("GameStartPanel").get_node("Title")
	Directions = hud_control.get_node("GameStartPanel").get_node("Directions")
	PlayButton = hud_control.get_node("GameStartPanel").get_node("Play_Button")
	game_over_panel = hud_control.get_node("GameOverPanel")
	reset_button_from_gameover = hud_control.get_node("GameOverPanel").get_node("ResetButton")
	home_button_from_gameover = hud_control.get_node("GameOverPanel").get_node("HomeButtonOnGameover")

	HighscoreButton = buttons.get_node("Highscore_Button")
	HomeButton = hud_control.get_node("Home_Button")
	
	game_scene = aspect_ratio_container.get_node("GameScene")
	lives_label = hud_control.get_node("LivesLabel")
	
	PlayButton.pressed.connect(_on_play_button_pressed)

	HighscoreButton.pressed.connect(_on_highscore_pressed)
	HomeButton.pressed.connect(_on_home_button_pressed)
	reset_button_from_gameover.pressed.connect(_on_reset_button_pressed)
	home_button_from_gameover.pressed.connect(_on_home_button_pressed)
	_start_highscore_list()
	_replace_highscore_list()
	_load_initials()
	
func _start_highscore_list():

	for game in ["simon_says","dino","creep","flappy","pong","attack","saucer","snake"]:
		initiate_highscores_section(game)

func _replace_highscore_list():
	high_score_popup_list.clear()
	for game in ["simon_says","dino","creep","flappy","pong","attack","saucer","snake"]:
		var game_first_line = "--- " + game +" Scores ---"
		var names = get_highscore_names(game)
		var scores = get_highscore_scores(game)
		high_score_popup_list.add_item(game_first_line)
		for i in range(names.size()):
			high_score_popup_list.add_item(names[i] + ": " + str(scores[i]))
			
func get_config_path_file():
	return config_file_path
	
func get_initials():
	return new_initials

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

func get_lives():
	return lives
	
func update_lives(change):
	lives += change
	lives_label.text = str(lives)

func set_or_reset_lives(default_lives = "INF"):
	if typeof(default_lives) == TYPE_INT:
		lives = default_lives
		lives_label.text = str(default_lives)
	else:
		lives=3
		lives_label.text = default_lives
		
func play_game_over():
	GameOverSound.play()

func play_applause():
	ApplauseSound.play()
	
#func get_initials_from_HUD() -> String:
#	return InitialsInput.text

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
	reset_score()
	set_or_reset_lives()
	GameManager.set_game_enabled(false)
	set_gameover_panel(false)
	child_node_to_delete = game_scene.get_children()
	if child_node_to_delete:
		buttons.visible = true
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
	high_score_popup.visible = !high_score_popup.visible
	pass # Replace with function body.

func _load_initials():
	InitialsInput.text = new_initials

func set_initials(initials):
	new_initials = initials
	InitialsInput.text = new_initials
	config.set_value("main", "initials",initials)
	config.save(perry_arcade_path)
	
func check_highscore_and_rank(section_name):
	print(score)
	var high_scores_names = config.get_value(section_name, "names", [])
	var high_scores = config.get_value(section_name, "scores", [])
#	var item_list = $HighScorePopup/ColorRect/ItemList
	if high_scores_names.size() != high_scores.size():
		print("Error: Names and scores arrays have different sizes.")
		return

	var added = false 

	for i in range(high_scores.size()):
		if score > high_scores[i]:


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

	config.save(perry_arcade_path)


	if(added):
		GameManager.play_applause()
	else:
		GameManager.play_game_over()
	_replace_highscore_list()
	
func initiate_highscores_section(game):
	if not config.has_section(game):
		config.set_value(game,"scores",[0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
		config.set_value(game,"names",["JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH"])
		config.save(perry_arcade_path)
		
func get_highscore_scores(game):

	var scores = config.get_value(game,"scores", [])
	
	return scores
	
func get_highscore_names(game):

	var names = config.get_value(game,"names", [])
	return names
	
func set_current_game_scene(scene):
	current_game_scene = scene

func get_current_game_scene():
	return current_game_scene

func get_game_enabled():
	return game_enabled

func set_game_enabled(status):
	game_enabled = status
