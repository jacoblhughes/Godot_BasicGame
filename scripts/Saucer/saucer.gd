extends Node2D

var c_p_1 = false
var c_p_2 = false
var c_p_3 = false
var finish = false
var score_value = 1
@onready var countdown_timer : Timer
@onready var game_timer : Timer
@onready var time_label : Label
var game_on = false
signal game_start
# Called when the node enters the scene tree for the first time.
func _ready():
	countdown_timer = get_parent().get_node("CountdownTimer")
	game_timer = get_parent().get_node("GameTimer")
	time_label = get_parent().get_node("CountdownTimerTime")
	_game_initialize()
	pass # Replace with function body.

func _game_initialize():
	print('dfdfd')
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_label()
	pass

func _on_maze_body_exited(body):
	print(body)
	_out_of_bounds()
	pass # Replace with function body.

func _on_melt_zone_body_entered(body):
	_out_of_bounds()
	pass # Replace with function body.

func _out_of_bounds():
	print('CRASH')


func _on_cp_1_body_entered(body):
	c_p_1 = true
	print('cp')
	pass # Replace with function body.


func _on_cp_2_body_entered(body):
	c_p_2 = true
	pass # Replace with function body.


func _on_cp_3_body_entered(body):
	c_p_3 = true
	pass # Replace with function body.

func _reset_checkpoints():
	c_p_1 = false
	c_p_2 = false
	c_p_3 = false
	finish = false

func _on_finish_body_entered(body):
	finish = true
	if(c_p_1 and c_p_2 and c_p_3 and finish):
		GameManager.update_score(score_value)
		_reset_checkpoints()
	pass # Replace with function body.

func _on_play_button_pressed():

	GameManager.set_game_enabled(true)
	countdown_timer.start()


func _on_countdown_timer_timeout():
	game_timer.start()
	game_start.emit()
	game_on = true
	pass # Replace with function body.

func _update_label():
	if not game_on:
	# Get the time left from the timer and format it as minutes:seconds
		var time_left = countdown_timer.time_left
		time_label.text = "%d:%02d" % [floor(time_left / 60), int(time_left) % 60]
	elif game_on:
		var time_left = game_timer.time_left
		time_label.text = "%d:%02d" % [floor(time_left / 60), int(time_left) % 60]
