extends Node2D

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 30

var skeeballs
# Called when the node enters the scene tree for the first time.
func _ready():

	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()

	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280
	print(xform , " " , yform)

	if yform > 1280:
#		%Camera2D.enabled = true
#		%Camera2D.zoom.y = yform/1280
		var nodes_to_move =[%Floor,%StartPosition,%Player,%JumpZone,%LeftWall,%RightWall,%PlayerDespawn,%Aim]
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = [%Floor,%LeftWall,%RightWall,%PlayerDespawn]
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var nodes_to_move =[%Floor,%StartPosition,%Player,%JumpZone,%Aim,%LeftBound,%RightBound,%LeftWall,%RightWall,%PlayerDespawn]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = [%Floor,%JumpZone,%PlayerDespawn]
		for node in nodes_to_scale:
			node.scale.x *= xatio


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):

	pass

func _on_play_button_pressed():
	HUD.set_start_timer_countdown_and_start()



func _on_game_over():
	GameManager.set_game_enabled(false)
	pass

func _on_scored():
	HUD.update_score()

func _on_start_timer_countdown_timeout():
	GameManager.set_game_enabled(true)
	HUD.set_game_time_left_and_start()

func _on_game_time_left_timer_timeout():
	HUD.update_lives()
