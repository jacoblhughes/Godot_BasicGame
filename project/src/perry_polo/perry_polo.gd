extends Node2D

signal position_reset

@onready var ball : CharacterBody2D
@onready var player : CharacterBody2D
@onready var computer : CharacterBody2D
@onready var background : TextureRect

var score_value = 1
var game_level = 1
var initial_lives = 3
var lives_lost = 1
var level_value = 1
var level_advance_value = 10

var game_reset = false

# Called when the node enters the scene tree for the first time.
func _ready():
	background = get_parent().get_node("Background")
	player = get_parent().get_node("Player")
	computer = get_parent().get_node("Computer")
	ball = get_parent().get_node("Ball")

	_game_initialize()

	pass # Replace with function body.
	
func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)
	GameManager.set_or_reset_lives(initial_lives)
	GameManager.set_or_reset_level(level_value)


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
			GameManager.update_score(score_value)
			_check_advance_level()
	
func _on_lose_body_entered(body):
	if body is PerryBall:
		position_reset.emit()
		GameManager.update_lives(-lives_lost)
		if(GameManager.get_lives()<=0):
			_game_over()
	pass # Replace with function body.

func _check_advance_level():
	if GameManager.get_score() % level_advance_value == 0:
		GameManager.update_game_level(level_value)
		computer.speed = computer.original_speed * pow(1.05,GameManager.get_game_level())
		ball.speed_increase=ball.original_speed_increase * pow(1.05,GameManager.get_game_level())
		ball.increased_velocity = ball.original_velocity * pow(1.05,GameManager.get_game_level())

		pass

func _game_over():
	GameManager.set_game_enabled(false)
	GameManager.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
