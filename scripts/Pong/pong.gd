extends Node2D

@onready var ball : RigidBody2D
@onready var player : StaticBody2D
@onready var computer : CharacterBody2D
var playerScore = 0
var computerScore = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Paddle - Player")
	computer = get_parent().get_node("Paddle - Computer")
	ball = get_parent().get_node("Ball")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	pass



func _on_ball_body_entered(body):
	print("Ball",body.name)
	if body.name == "Paddle - Computer" or body.name == "Paddle - Player":
		print('increasing')
		ball.linear_velocity = ball.linear_velocity.normalized() * (ball.linear_velocity.length() * 1.20)
		#keep collition from occuring right after
#		ball.get_node("CollisionShape2D").disabled = true
#		await(.5)  # Wait for 0.5 seconds
	if body.name == "Win":
		print("Win")
		playerScore +=1
	if body.name == "Lose":
		print("Lose")
#		# Re-enable collision
		playerScore -=1

func _on_ball_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	

	pass # Replace with function body.


func _on_player_2_body_entered(body):

	print("Player ",body.name)
	pass # Replace with function body.


func _on_player_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):


	pass # Replace with function body.
