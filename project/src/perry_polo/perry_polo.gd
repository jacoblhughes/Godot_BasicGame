extends Node2D

signal position_reset

@onready var ball : CharacterBody2D
@onready var player : CharacterBody2D
@onready var enemy : CharacterBody2D
@onready var background : TextureRect

var score_value = 1
var game_level = 1
var initial_lives = 3
var lives_lost = 1
var level_value = 1
var level_advance_value = 10
var win_area
var lose_area
var game_reset = false
var whirlpools
# Called when the node enters the scene tree for the first time.
func _ready():
	background = get_parent().get_node("Background")
	player = get_parent().get_node("Player")
	enemy = get_parent().get_node("Enemy")
	ball = get_parent().get_node("Ball")
	whirlpools = get_tree().get_nodes_in_group("perry_polo_whirlpool")
	win_area = get_parent().get_node("Win")
	win_area.body_entered.connect(_on_win_body_entered)
	lose_area = get_parent().get_node("Lose")
	lose_area.body_entered.connect(_on_lose_body_entered)
	_game_initialize()
	

		
func _game_initialize():
	HUD.reset_score()
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_lives(initial_lives)
	HUD.set_or_reset_level(level_value)


func _on_play_button_pressed():

	GameManager.set_game_enabled(true)


func on_reset_button_reset_button_pressed():
	game_reset = true

	GameManager.set_game_enabled(false)
	GameManager.reset_score()
	
	pass # Replace with function body.


func _on_win_body_entered(body):
	if(GameManager.get_game_enabled()):
		if body is PerryBall:
			position_reset.emit()
			HUD.update_score(score_value)
			_check_advance_level()
	
func _on_lose_body_entered(body):
	if body is PerryBall:
		position_reset.emit()
		HUD.update_lives(-lives_lost)
		if(HUD.get_lives()<=0):
			_game_over()
	pass # Replace with function body.

func _check_advance_level():
	if HUD.get_score() % level_advance_value == 0:
		HUD.update_game_level(level_value)
		enemy.speed = enemy.original_speed * pow(1.05,GameManager.get_game_level())
		ball.speed_increase=ball.original_speed_increase * pow(1.05,GameManager.get_game_level())
		ball.increased_velocity = ball.original_velocity * pow(1.05,GameManager.get_game_level())

		pass

func _game_over():
	GameManager.set_game_enabled(false)
	GameManager.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
