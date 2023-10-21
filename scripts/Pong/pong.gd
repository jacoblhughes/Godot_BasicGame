extends Node2D

signal position_reset

@onready var ball : CharacterBody2D
@onready var player : CharacterBody2D
@onready var computer : CharacterBody2D
@onready var HUDSIGNALS = get_tree().get_root().get_node("Main").get_node("HUD_SCENE")
var playerScore = 0
var computerScore = 0
var game_disabled = true
var original_position = Vector2(0,0)
var game_reset = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Paddle - Player")
	computer = get_parent().get_node("Paddle - Computer")
	ball = get_parent().get_node("Ball")
	HUDSIGNALS.startButtonPressed.connect(_on_play_button_pressed)
	HUDSIGNALS.resetButtonPressed.connect(on_reset_button_reset_button_pressed)
	original_position = ball.position

	pass # Replace with function body.

func _change_game_disabled(value):
	game_disabled = value

func _on_play_button_pressed():

		game_disabled = false


func on_reset_button_reset_button_pressed():
	game_reset = true

	_change_game_disabled(true)
	HUDVariables.set_new_score(0)
	
	pass # Replace with function body.


func _on_win_body_entered(body):
	#first to 11
	
	if body.name == "Ball":
		position_reset.emit()
		HUDVariables.set_new_score(1)
	pass # Replace with function body.


func _on_lose_body_entered(body):
	if body.name == "Ball":
		position_reset.emit()
		HUDVariables.set_new_score(-1)
	pass # Replace with function body.
