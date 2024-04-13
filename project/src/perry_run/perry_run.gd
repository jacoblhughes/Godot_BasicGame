extends Node2D

var c_p_1_hit = false
var c_p_2_hit = false
var c_p_3_hit = false
var finish_hit = false
var score_value = 1


var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable

var level_value = 1
var reset_point
var game_on = false

signal game_start
signal out_of_bounds(new_target_position)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	%CheckPoint1.body_entered.connect(_on_cp_1_body_entered)
	%CheckPoint2.body_entered.connect(_on_cp_2_body_entered)
	%CheckPoint2.body_entered.connect(_on_cp_3_body_entered)
	%Finish.body_entered.connect(_on_finish_body_entered)
	%RaceTrack.body_exited.connect(_on_race_track_body_exited)
	%MeltZone.body_entered.connect(_on_melt_zone_body_entered)
#	_game_initialize()
	reset_point = %Finish.position
	
	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280
	print(xform , " " , yform)
	if yform > 1280:
		%Camera2D.enabled = true
		%Camera2D.zoom.y = yform/1280

	if xform > 720:
		var nodes_to_move =[%CheckPoint1,%CheckPoint2,%CheckPoint3,%Finish,%RaceTrack,%MeltZone,%Player]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = [%TileMap]
		for node in nodes_to_scale:
			node.scale.x *= xatio
		
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()
	
	
	pass # Replace with function body.


func _process(_delta):

	pass

func _on_race_track_body_exited(body):
	_out_of_bounds()
	pass # Replace with function body.

func _on_melt_zone_body_entered(body):
	_out_of_bounds()
	pass # Replace with function body.

func _out_of_bounds():

	%Player.position = reset_point
	out_of_bounds.emit(reset_point)

func _on_cp_1_body_entered(body):
	if c_p_1_hit == false:
		HUD.update_score(score_value)
	c_p_1_hit=true
	reset_point = %CheckPoint1.position
	pass # Replace with function body.


func _on_cp_2_body_entered(body):
	if c_p_2_hit == false:
		HUD.update_score(score_value)
	c_p_2_hit=true
	reset_point = %CheckPoint2.position
	pass # Replace with function body.


func _on_cp_3_body_entered(body):
	if c_p_3_hit == false:
		HUD.update_score(score_value)
	c_p_3_hit=true
	reset_point = %CheckPoint3.position
	pass # Replace with function body.

func _on_finish_body_entered(body):

	if GameManager.get_game_enabled():
		finish_hit=true
		reset_point = %Finish.position
		if finish_hit == true and c_p_1_hit == true and c_p_2_hit == true and c_p_3_hit == true:
			HUD.update_score(score_value)
			if HUD.check_advance_level():
				advance_level()
	
	_reset_checkpoints()
	pass # Replace with function body.

func _on_play_button_pressed():

	GameManager.set_game_enabled(true)
	HUD.countdown_timer_start_and_time_left()

func _reset_checkpoints():
	c_p_1_hit = false
	c_p_2_hit = false
	c_p_3_hit = false
	finish_hit = false

func _on_countdown_timer_timeout():

	HUD.game_left_timer_start()
	game_start.emit()
	game_on = true

	pass # Replace with function body.

func advance_level():
	
	pass



func _on_game_left_timer_timeout():
	HUD.update_lives(-1)

func _on_game_over():
	reset_point = %Finish.position
	_out_of_bounds()
	GameManager.set_game_enabled(false)
	GameStartGameOver.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()

	pass # Replace with function body.
