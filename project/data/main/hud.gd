extends CanvasLayer
var score = 0
var lives  = 0
var game_level = 0
var child_node_to_delete
# Export the NodePath to the player_initials scene

@onready var game_scene : Node = get_tree().get_root().get_node("Main")

signal hud_ready
signal startButtonPressed
signal resetButtonPressed
# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func update_initials(value):
	%Initials.text = value
	
func get_initials():
	return(%Initials.text)
	
func set_new_score(new_score):
	score = new_score
	var this_score = str(score)
	%Score.text = this_score
			
func update_score(new_score):
	score += new_score
	var this_score = str(score)
	%Score.text = this_score
		
func reset_score():
	score=0
	%Score.text = str(score)

func get_score():
	return score

func set_game(flag,title,directions):
	%GameStartPanel.visible = flag
	%Title.text=title
	%Directions.text = directions

func set_or_reset_level(default_level = "INF"):
	if typeof(default_level) == TYPE_INT:
		game_level = default_level
		%LevelLabel.text = str(game_level)
	else:
		%LevelLabel.text = default_level
			
func update_game_level(new_level):
	game_level += new_level
	var this_level = str(game_level)
	%LevelLabel.text = this_level

func _on_home_button_pressed():
	if !Background.visible:
		Background.visible = true
	reset_score()
	set_or_reset_lives()
	GameManager.set_game_enabled(false)
	set_gameover_panel(false)
	set_gameover_panel_congrats(false)
	child_node_to_delete = game_scene.get_children()
	if child_node_to_delete:
		Buttons.visible = true
		for child in child_node_to_delete:
			child.queue_free()
	HUD.set_or_reset_level()

	pass # Replace with function body.
	
func _on_play_button_pressed():
	%GameStartPanel.visible = false
	startButtonPressed.emit()
	pass # Replace with function body.

func set_gameover_panel(flag):
	%GameOverPanel.visible = flag

func set_gamestart_panel(flag):
	%GameStartPanel.visible = flag

func set_gameover_panel_congrats(vis):
	%GameOverPanel.visible = vis
	if(vis):
#		game_over_panel_congrats.play()
		%HappyRect.visible = true
	else:
#		game_over_panel_congrats.stop()
		%HappyRect.visible = false

func _on_reset_button_pressed():
	set_gameover_panel(false)
	resetButtonPressed.emit()
	child_node_to_delete = game_scene.get_children()
	if child_node_to_delete:
		for child in child_node_to_delete:
			child.queue_free()
	set_game_again()
	pass # Replace with function body.
	
func set_or_reset_lives(default_lives = "INF"):
	if typeof(default_lives) == TYPE_INT:
		lives = default_lives
		%LivesLabel.text = str(default_lives)
	else:
		lives=3
		%LivesLabel.text = default_lives
		
func set_game_again():
	game_scene.add_child(GameManager.current_game_scene.instantiate(),true)
	set_gamestart_panel(true)

func get_lives():
	return lives
	
func update_lives(change):
	lives += change
	%LivesLabel.text = str(lives)

func check_advance_level(advance_value,level_value):
		if(get_score() % advance_value == 0):
			update_game_level(level_value)
			return true
			
func get_game_level():
	return game_level

func set_initials(initials):
	var new_initials = initials
	update_initials(new_initials)
	GameManager.save_initials(new_initials)
