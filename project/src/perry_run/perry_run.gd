extends Node2D

@export var player_scene : PackedScene

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 60

var level_value = 1
var reset_point
var game_on = false


signal game_start
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
		var nodes_to_move =[]
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var nodes_to_move =[]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.x *= xatio

	%PlayerFell.body_entered.connect(_on_player_fall_out)
	%PlayerPushed.body_entered.connect(_on_player_fall_out)
	pass # Replace with function body.


func _process(_delta):

	pass

func _on_play_button_pressed():
	game_start.emit()
	var player = player_scene.instantiate()
	player.position = %StartPosition.position
	add_child.call_deferred(player)
	pass

func advance_level():
	pass

func _on_player_fall_out():
	HUD.update_lives()

func _on_game_over():
	pass
