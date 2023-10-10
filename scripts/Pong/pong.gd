extends Node2D

@onready var ball : RigidBody2D
@onready var player : StaticBody2D
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#
#	pass



func _on_ball_body_entered(body):
	print("Ball",body.name)
	if body.name == "Paddle - Computer" or body.name == "Paddle - Player":

		ball.linear_velocity = ball.linear_velocity.normalized() * (ball.linear_velocity.length() * 1.20)
		#keep collition from occuring right after
#		ball.get_node("CollisionShape2D").disabled = true
#		await(.5)  # Wait for 0.5 seconds


func _on_ball_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	

	pass # Replace with function body.


func _on_player_2_body_entered(body):

	print("Player ",body.name)
	pass # Replace with function body.


func _on_player_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):


	pass # Replace with function body.



func _on_win_body_entered(body):
	if(body.name == "Ball"):
		print("Win")
		HUDVariables.set_new_score(1)
		print(body.name)
	pass # Replace with function body.


func _on_lose_body_entered(body):
	if(body.name == "Ball"):
		print("Lose")
		HUDVariables.set_new_score(-1)
		print(body.name)
	pass # Replace with function body.

func _change_game_disabled(value):
	game_disabled = value

func _on_play_button_pressed():
		ball.linear_velocity = Vector2(-100,-100)
		game_disabled = false

func _integrate_forces(state):
	print(state)
	print('here')
	if game_reset == true:
		print('heeeeeeeeeeee')
		ball.position = original_position
		ball.linear_velocity = Vector2(0, 0)
		game_reset = false
	else:
		# Apply your regular physics logic here
		# This is where you would handle movement, forces, etc.
		pass
	
func on_reset_button_reset_button_pressed():
	print('reset',original_position)
	game_reset = true
	print(game_reset)

#	ball.linear_velocity = Vector2(0,0)
#	print(original_position)
#	ball.position= original_position


	_change_game_disabled(true)
	HUDVariables.set_new_score(0)
	
	pass # Replace with function body.
