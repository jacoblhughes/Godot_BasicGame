extends Node2D

signal position_reset

@onready var ball : CharacterBody2D
@onready var player : CharacterBody2D
@onready var computer : CharacterBody2D

var score_value = 1
var game_level = 1


var game_reset = false
# Called when the node enters the scene tree for the first time.
func _ready():

	player = get_parent().get_node("Paddle - Player")
	computer = get_parent().get_node("Paddle - Computer")
	ball = get_parent().get_node("Ball")

	_game_initialize()

	pass # Replace with function body.

func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)




func _on_play_button_pressed():

	GameManager.set_game_enabled(true)


func on_reset_button_reset_button_pressed():
	game_reset = true

	GameManager.set_game_enabled(false)
	GameManager.reset_score()
	
	pass # Replace with function body.


func _on_win_body_entered(body):
	#first to 11

	if body.name == "Ball":
		position_reset.emit()
		GameManager.update_score(score_value)
	if GameManager.get_score() >= 11:
		_next_level_reached()
	
func _on_lose_body_entered(body):
	if body.name == "Ball":
		position_reset.emit()
		GameManager.update_score(-score_value)
	pass # Replace with function body.

func _next_level_reached():

	ball.speed_increase=ball.speed_increase + .1
	ball.original_velocity = ball.original_velocity * 1.1
	var level_label = get_parent().get_node("LevelLabel")
	game_level += 1
	level_label.text = str(game_level)
	pass
