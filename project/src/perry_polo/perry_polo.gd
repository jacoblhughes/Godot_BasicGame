
extends Node2D

signal position_reset

@onready var background : TextureRect

var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable


var score_value = 1
var lives_lost = 1

var old_position = Vector2.ZERO
var second_position = Vector2.ZERO

var win_area
var lose_area
var game_reset = false
@export var whirlpool : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	print(get_viewport_rect())
	print(get_viewport_transform())
	var whirlpools = whirlpool.get_children()
	if yform > 1280:
		%Camera2D.enabled = true
		%Camera2D.zoom.y = yform/1280

	if xform > 720:
		var xatio = xform/720
		%Lose.position.x *= xatio
		%Win.position.x *= xatio
		%Lose.scale *= xatio
		%Win.scale *= xatio
		%WallTop.position.x *= xatio
		%WallBottom.position.x *= xatio
		%WallTop.scale.x *= xatio
		%WallBottom.scale.x *= xatio
		print(%Enemy.position)
		%Enemy.set_x_position(%Enemy.position.x * xatio)
		print(%Enemy.position)
		%Ball.position.x *= xatio
		%PlayerStart.position.x *= xatio
		%Player.position.x *= xatio
		
		for node in whirlpools:
			node.position.x *= xatio


	%Win.body_entered.connect(_on_win_body_entered)

	%Lose.body_entered.connect(_on_lose_body_entered)
#	_game_initialize()
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	
func _draw():
	if second_position != Vector2.ZERO:
			draw_line(old_position,second_position,Color.BLACK,25)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_win_body_entered(body):
	if(GameManager.get_game_enabled()):
		if body is PerryBall:
			print('here')
			position_reset.emit()
			HUD.update_score(score_value)
			if HUD.check_advance_level():
				advance_level()
	
func _on_lose_body_entered(body):
	if body is PerryBall:
		position_reset.emit()
		HUD.update_lives(-lives_lost)
	pass # Replace with function body.

func advance_level():
	%Enemy.speed = %Enemy.original_speed * pow(1.05,HUD.get_game_level())
	%Ball.speed_increase= %Ball.original_speed_increase * pow(1.05,HUD.get_game_level())
	%Ball.increased_velocity = %Ball.original_velocity * pow(1.05,HUD.get_game_level())
	pass

func _on_game_over():
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
