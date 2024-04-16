
extends Node2D

signal position_reset

@onready var background : TextureRect

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3

var old_position = Vector2.ZERO
var second_position = Vector2.ZERO

var win_area
var lose_area
var game_reset = false
@export var whirlpools : Node2D
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

	
	if yform > 1280:
		var nodes_to_move = [%Lose,%Win,%WallTop,%WallBottom,%Enemy,%Ball,%Player]
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = [%Lose,%Win,%WallTop,%WallBottom]
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var obstacles = whirlpools
		if whirlpools.get_child_count() > 0:
			for node in obstacles.get_children():
				node.position.x *= xatio
		var nodes_to_move = [%Lose,%Win,%WallTop,%WallBottom,%Enemy,%Ball,%Player]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = [%Lose,%Win,%WallTop,%WallBottom]
		for node in nodes_to_scale:
			node.scale.x *= xatio


	%Win.body_entered.connect(_on_win_body_entered)
	%Lose.body_entered.connect(_on_lose_body_entered)
#	_game_initialize()


func _draw():
	if second_position != Vector2.ZERO:
			draw_line(old_position,second_position,Color.BLACK,25)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_win_body_entered(body):
	if(GameManager.get_game_enabled()):
		if body is PerryBall:

			position_reset.emit()
			HUD.update_score()
			if HUD.check_advance_level():
				advance_level()
	
func _on_lose_body_entered(body):
	if body is PerryBall:
		position_reset.emit()
		HUD.update_lives()
	pass # Replace with function body.

func advance_level():
	%Enemy.speed = %Enemy.original_speed * pow(1.05,HUD.return_game_level())
	%Ball.speed_increase= %Ball.original_speed_increase * pow(1.05,HUD.return_game_level())
	%Ball.increased_velocity = %Ball.original_velocity * pow(1.05,HUD.return_game_level())
	pass

func _on_game_over():
	pass
