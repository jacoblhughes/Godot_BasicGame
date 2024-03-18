extends Node2D

var c_p_1 = false
var c_p_2 = false
var c_p_3 = false
var finish = false
var score_value = 1
@onready var countdown_timer : Timer
@onready var game_timer : Timer
@onready var time_label : Label
@onready var player : CharacterBody2D
@onready var c_p_1_area : Area2D
@onready var c_p_2_area : Area2D
@onready var c_p_3_area : Area2D
@onready var finish_area : Area2D
var level_advance_value = 4
var level_value = 1
var reset_point
var game_on = false
signal game_start
signal out_of_bounds(new_target_position)
# Called when the node enters the scene tree for the first time.
func _ready():
	c_p_1_area = get_parent().get_node("CP1")
	c_p_2_area = get_parent().get_node("CP2")
	c_p_3_area = get_parent().get_node("CP3")
	finish_area = get_parent().get_node("Finish")
	countdown_timer = get_parent().get_node("CountdownTimer")
	game_timer = get_parent().get_node("GameTimer")
	time_label = %TimerLayer.get_node("CountdownTimerTime")
	player = get_parent().get_node("Player")
	_game_initialize()
	reset_point = finish_area.position
	pass # Replace with function body.

func _game_initialize():
	HUD.reset_score()
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_level(1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_update_label()
	pass

func _on_maze_body_exited(body):
	_out_of_bounds()
	pass # Replace with function body.

func _on_melt_zone_body_entered(body):
	_out_of_bounds()
	pass # Replace with function body.

func _out_of_bounds():

	player.position = reset_point
	out_of_bounds.emit(reset_point)

func _on_cp_1_body_entered(body):
	if c_p_1 == false:
		HUD.update_score(score_value)
	c_p_1=true
	reset_point = c_p_1_area.position
	pass # Replace with function body.


func _on_cp_2_body_entered(body):
	if c_p_2 == false:
		HUD.update_score(score_value)
	c_p_2=true
	reset_point = c_p_2_area.position
	pass # Replace with function body.


func _on_cp_3_body_entered(body):
	if c_p_3 == false:
		HUD.update_score(score_value)
	c_p_3=true
	reset_point = c_p_3_area.position
	pass # Replace with function body.

func _on_finish_body_entered(body):

	if GameManager.get_game_enabled():
		
		reset_point = finish_area.position
		if finish == false:
			HUD.update_score(score_value)
			if HUD.check_advance_level(level_advance_value,level_value):
				advance_level()
		finish=true
	
	_reset_checkpoints()
	pass # Replace with function body.

func _on_play_button_pressed():

	GameManager.set_game_enabled(true)
	countdown_timer.start()

func _reset_checkpoints():
	c_p_1 = false
	c_p_2 = false
	c_p_3 = false
	finish = false

func _on_countdown_timer_timeout():

	game_timer.start()
	game_start.emit()
	game_on = true

	pass # Replace with function body.

func advance_level():
	pass

func _update_label():

	if not game_on:
	# Get the time left from the timer and format it as minutes:seconds
		var time_left = countdown_timer.time_left
		time_label.text = "%d:%02d" % [floor(time_left / 60), int(time_left) % 60]
	elif game_on:
		var time_left = game_timer.time_left
		time_label.text = "%d:%02d" % [floor(time_left / 60), int(time_left) % 60]


func _on_game_timer_timeout():
	reset_point = finish_area.position
	_out_of_bounds()
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()

	pass # Replace with function body.
