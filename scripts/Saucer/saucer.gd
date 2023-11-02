extends Node2D

var c_p_1 = true
var c_p_2 = true
var c_p_3 = true
var finish = true
var score_value = 1
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_maze_body_exited(body):
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


func _on_finish_body_entered(body):
	finish = true
	if(c_p_1 and c_p_2 and c_p_3 and finish):
		GameManager.update_score(score_value)
	pass # Replace with function body.

func _on_play_button_pressed():
	print('jhere')
	GameManager.set_game_enabled(true)
