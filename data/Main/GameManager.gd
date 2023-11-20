extends Node

# Export the NodePath to the player_initials scene
var config = ConfigFile.new()

@onready var InitialsInput : Label
@onready var ScoreLabel : Label
@onready var StatusLabel : Label


@onready var BackGroundMusic: AudioStreamPlayer
@onready var PlayArea: ColorRect
@onready var GameStartPanel : Panel
@onready var Title : Label
@onready var Directions : Label


@onready var PlayButton : Button
@onready var ResetButton : Button
@onready var HighscoreButton : Button
@onready var HomeButton : Button
var child_node_to_delete

@onready var new_initials
@onready var game_over_panel : Panel
@onready var reset_button_from_gameover : Button
@onready var home_button_from_gameover : Button
@onready var game_scene : Node
@onready var lives_label : Label
@onready var aspect_ratio_container
@onready var buttons : Control
@onready var hud_control : Control
@onready var main_node : Control
@onready var game_over_panel_congrats : AnimatedSprite2D
var perry_arcade_path = "user://perry_arcade.cfg"
var lives = 3
var score = 0
var game_enabled = false
var current_game_scene : PackedScene
const DEFAULT_FLOAT = -1.0
const DEFAULT_TEXT = "-1"
signal startButtonPressed
signal resetButtonPressed
signal highscoreButtonpressed
signal initialsUpdated
var game_key = "JLH"
var games_list : Dictionary = {
"1":{"title":"Perry Says","short_name":"perry_says","directions":"Smash Perry in the right order to get the high score!"}
,"2":{"title":"Python Perry","short_name":"perry_python","directions":"Make Perry eat the unfunny clown!"}
,"3":{"title":"Perry Water Polo","short_name":"perry_polo","directions":"Bounce Perry around to get the highscore!"}
,"4":{"title":"Perry's Llama Leap","short_name":"perry_llama","directions":"Perry stole your headband. Jump over his garbage as you chase him down!"}
,"5":{"title":"Perry Dodge","short_name":"perry_dodge","directions":"Help Perry avoid the zoo animals!"}
,"6":{"title":"Perry Flap","short_name":"perry_flap","directions":"Perry is trying to stop the bird from getting home. Help flappy!"}
,"7":{"title":"Perry Run","short_name":"perry_run","directions":"Get to the end of the maze as fast as you can and as many times as you can!"}
,"8":{"title":"Perry Space Attack","short_name":"perry_space","directions":"Roddy needs help avoiding the Vegaliens"}

}
# Called when the node enters the scene tree for the first time.
func _ready():
	
	main_node = get_tree().get_root().get_node("Main")
	aspect_ratio_container = main_node.get_node("AspectRatioContainer").get_node("Control")
	buttons = aspect_ratio_container.get_node("Buttons")


	hud_control = aspect_ratio_container.get_node("HUD")
	InitialsInput = hud_control.get_node("Initials")
	ScoreLabel = hud_control.get_node("Score")

	
	PlayArea = aspect_ratio_container.get_node("PlayArea")
	GameStartPanel = hud_control.get_node("GameStartPanel")
	Title = hud_control.get_node("GameStartPanel").get_node("Title")
	Directions = hud_control.get_node("GameStartPanel").get_node("Directions")
	PlayButton = hud_control.get_node("GameStartPanel").get_node("Play_Button")
	game_over_panel = hud_control.get_node("GameOverPanel")
	game_over_panel_congrats = game_over_panel.get_node("AnimatedSprite2D")
	reset_button_from_gameover = hud_control.get_node("GameOverPanel").get_node("ResetButton")
	home_button_from_gameover = hud_control.get_node("GameOverPanel").get_node("HomeButtonOnGameover")


	HomeButton = hud_control.get_node("Home_Button")
	
	game_scene = aspect_ratio_container.get_node("GameScene")
	lives_label = hud_control.get_node("LivesLabel")
	
	PlayButton.pressed.connect(_on_play_button_pressed)


	HomeButton.pressed.connect(_on_home_button_pressed)
	reset_button_from_gameover.pressed.connect(_on_reset_button_pressed)
	home_button_from_gameover.pressed.connect(_on_home_button_pressed)
	main_node.main_ready.connect(_on_main_ready)

	var file_exists = FileAccess.file_exists(perry_arcade_path)
	if(!file_exists):

		var file = FileAccess.open(perry_arcade_path, FileAccess.WRITE_READ)
		file.store_string("[main]\n")
		file.store_string("\n")
		file.store_string("initials=\"JLH\"\n")
		file.store_string("\n")
		file.store_string("[background_music]\n")
		file.store_string("\n")
		file.store_string("value=1\n")
		file.store_string("playing=0\n")
		file.store_string("\n")
		file.store_string("[game_music]\n")
		file.store_string("\n")
		file.store_string("value=1\n")
		file.store_string("playing=0\n")
		file.close()
		config.load(perry_arcade_path)
	else:
		config.load(perry_arcade_path)
		if config.get_value("main", "initials",DEFAULT_TEXT) != DEFAULT_TEXT:
			pass
		else:
			config.set_value("main", "initials","JLH")
			config.save(perry_arcade_path)
		
		if config.get_value("background_music", "value", DEFAULT_FLOAT) != DEFAULT_FLOAT:
			pass
		else:
			config.set_value("background_music", "value",0.5)
			config.save(perry_arcade_path)

		if config.get_value("background_music", "playing", DEFAULT_FLOAT) != DEFAULT_FLOAT:
			pass
		else:
			config.set_value("background_music", "playing",0)
			config.save(perry_arcade_path)

		if config.get_value("game_music", "value", DEFAULT_FLOAT) != DEFAULT_FLOAT:
			pass
		else:
			config.set_value("game_music", "value",0.5)
			config.save(perry_arcade_path)

		if config.get_value("game_music", "playing", DEFAULT_FLOAT) != DEFAULT_FLOAT:
			pass
		else:
			config.set_value("game_music", "playing",0)
			config.save(perry_arcade_path)

	new_initials = config.get_value("main", "initials")
	
	initiate_highscores_section()
	_load_initials()	
		
			

	
func get_games_list():
	return games_list
	
func get_config_path_file():
	return perry_arcade_path
	
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
	set_gameover_panel_congrats(false)
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

func set_gameover_panel_congrats(vis):
	game_over_panel_congrats.visible = vis
	if(vis):
		game_over_panel_congrats.play()
	else:
		game_over_panel_congrats.stop()
	

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

func _load_initials():
	InitialsInput.text = new_initials

func set_initials(initials):
	new_initials = initials
	InitialsInput.text = new_initials
	config.set_value("main", "initials",initials)
	config.save(perry_arcade_path)
	
func check_highscore_and_rank():
	var high_scores_names = config.get_value(game_key, "names", [])
	var high_scores = config.get_value(game_key, "scores", [])
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
		GameManager.set_gameover_panel_congrats(true)
#	_replace_highscore_list()
	
func initiate_highscores_section():
	for key in games_list.keys():
		if not config.has_section(key):
			config.set_value(key,"scores",[0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
			config.set_value(key,"names",["JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH", "JLH"])
			config.save(perry_arcade_path)
		
func get_highscore_scores(key):

	var scores = config.get_value(key,"scores", [])
	
	return scores
	
func get_highscore_names(key):

	var names = config.get_value(key,"names", [])
	return names
	
func set_current_game_scene(scene):
	current_game_scene = scene

func get_current_game_scene():
	return current_game_scene

func get_game_list_values(key):
	return games_list[key]

func get_game_enabled():
	return game_enabled

func set_game_enabled(status):
	game_enabled = status

func set_game_key(key):
	game_key = key

func _on_main_ready():

	AudioManager.update_background_music(config.get_value("background_music", "value", DEFAULT_FLOAT))
	AudioManager.set_background_music_mute(config.get_value("background_music", "playing", DEFAULT_FLOAT))
	AudioManager.update_game_music(config.get_value("game_music", "value", DEFAULT_FLOAT))
	AudioManager.set_game_music_mute(config.get_value("game_music", "playing", DEFAULT_FLOAT))
	AudioManager.game_file_ready()
