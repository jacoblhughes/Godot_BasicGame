extends CanvasLayer

var child_node_to_delete
var timer_used = false
var counting_down = false
var game_left_timing = false
var time_left = false
var time_passed = false

var score = 0
var lives  = 0
var game_level = 0

var initial_score_value : int
var initial_lives_value : int
var initial_level_value : int
var level_advance_check_value : int
var level_advance_value : int

@onready var game_scene : Node = get_tree().get_root().get_node("Main")

signal hud_ready

signal startButtonPressed
signal game_over

signal countdown_timer_timeout
signal game_left_timer_timeout
signal clickable_input_event
# Called when the node enters the scene tree for the first time.
func _ready():
#	print(DisplayServer.get_display_safe_area())
#	print(DisplayServer.screen_get_usable_rect())
	pass
func _process(delta):
	if time_left:
		if timer_used and counting_down:
			var countdown_timer_left = %StartCountdownTimer.time_left
			%Time.text = "%d:%02d" % [floor(countdown_timer_left / 60), int(countdown_timer_left) % 60]
		if timer_used and game_left_timing:
			var game_left_timer = %GameLeftTimer.time_left
			%Time.text = "%d:%02d" % [floor(game_left_timer / 60), int(game_left_timer) % 60]
	pass
	
func update_initials(value):
	%Initials.text = value
	
func return_initials():
	return(%Initials.text)

func update_score(value):
	var old_score = score
	var new_score = old_score + value
	score = new_score
	var score_text = str(score)
	%Score.text = score_text
	
func set_or_reset_score(value = 0):
	var new_score
	if value != 0:
		new_score = value
	else:
		new_score = 0
	%Score.text = str(new_score)


func return_score():
	return score

func set_game(flag,title,directions):
	%GameStartPanel.visible = flag
	%Title.text=title
	%Directions.text = directions

func set_or_reset_level(default_level = "INF"):
	if typeof(default_level) == TYPE_INT:
		game_level = default_level
		%Level.text = str(game_level)
	else:
		%Level.text = default_level
			
func update_game_level(new_level):
	game_level += new_level
	var this_level = str(game_level)
	%Level.text = this_level

func _on_home_button_pressed():
	if !Background.visible:
		Background.visible = true

	clear_hud()

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
		%HighscoreAchieved.visible = true
	else:
#		game_over_panel_congrats.stop()
		%HighscoreAchieved.visible = false
		
func set_or_reset_lives(default_lives = "INF"):
	if typeof(default_lives) == TYPE_INT:
		lives = default_lives
		%Lives.text = str(default_lives)
	else:
		lives=3
		%Lives.text = default_lives
		
func set_game_again():
	game_scene.add_child(GameManager.current_game_scene.instantiate(),true)
	set_gamestart_panel(true)

func return_lives():
	return lives
	
func update_lives(change):
	print(lives)
	var old_lives = lives
	var new_lives = old_lives + change
	lives = new_lives
	if lives <= 0:
		game_over.emit()
	else:
		%Lives.text = str(lives)
	

func check_advance_level():
		if(return_score() % level_advance_check_value == 0):
			update_game_level(level_advance_value)
			return true
			
func get_game_level():
	return game_level

func countdown_timer_start_and_time_left():
	timer_used = true
	counting_down = true
	time_left = true
	%StartCountdownTimer.start()


func _on_countdown_timer_timeout():
	countdown_timer_timeout.emit()
	pass # Replace with function body.

func game_left_timer_start():
	%GameLeftTimer.start()
	game_left_timing = true
	
func clear_hud():
	set_or_reset_score()
	set_or_reset_lives()
	timer_used = false
	counting_down = false
	game_left_timing = false
	time_left = false
	time_passed = false
	%Time.text = "INF"
	%StartCountdownTimer.stop()
	%StartCountdownTimer.wait_time = 3
	%GameLeftTimer.stop()
	%GameLeftTimer.wait_time = 60
	%GamePassedTimer.stop()
	%GamePassedTimer.wait_time = 1

func _on_game_left_timer_timeout():
	game_left_timer_timeout.emit()
	pass # Replace with function body.


func _on_game_passed_timer_timeout():
	pass # Replace with function body.


func _on_panel_gui_input(event):
	if event is InputEventScreenTouch and event.pressed:
		clickable_input_event.emit(event,event.position)
	pass # Replace with function body.

func get_play_area_position():
	return %InputPanel.global_position

func get_play_area_size():
	return %InputPanel.size

func hud_initialize(this_initial_score_value, this_initial_lives_value, this_initial_level_value, this_level_advance_check_value, this_level_advance_value, this_start_button_callable, this_game_over_callable):
	initial_score_value = this_initial_score_value
	initial_lives_value = this_initial_lives_value
	initial_level_value = this_initial_level_value
	level_advance_check_value = this_level_advance_check_value
	level_advance_value = this_level_advance_value
	set_or_reset_score(initial_score_value)
	set_or_reset_lives(initial_lives_value)
	set_or_reset_level(initial_level_value)
	startButtonPressed.connect(this_start_button_callable)
	game_over.connect(this_game_over_callable)
#	HUD.countdown_timer_timeout.connect(_on_countdown_timer_timeout)
#	HUD.game_left_timer_timeout.connect(_on_game_left_timer_timeout)
#	HUD.countdown_timer_timeout.connect(_on_countdown_timer_timeout)
#	HUD.game_left_timer_timeout.connect(_on_game_left_timer_timeout)
