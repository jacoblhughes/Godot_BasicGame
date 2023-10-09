extends StaticBody2D

@onready var ball : RigidBody2D
var lag_timer = 0.0
var lag_duration = 0.5  # Adjust this value to control the lag duration

# Called when the node enters the scene tree for the first time.
func _ready():
	ball = get_parent().get_node("Ball")
	pass # Replace with function body.



func _physics_process(delta):
	var ball_pos = ball.position

	# Calculate the distance between the node and the ball
	var distance = abs(position.y - ball_pos.y)

	# Calculate the new position of the node, 10% of the distance between the ball and the node
	var new_y = ball_pos.y + (distance * 0.1)

	# Update the node's position
	position.y = new_y

#func _physics_process(delta):
#	var ball_pos = ball.position
#
#	# Calculate the distance between the node and the ball
#	var distance = abs(position.y - ball_pos.y)
#
#	# Calculate the new position of the node, always halfway between the ball and the node
#	var new_y = ball_pos.y + (distance / 30.0)
#
#	# Calculate the velocity to move towards the new position
#	var velocity = (Vector2(0, new_y) - position).normalized() * ball.velocity.y  # Replace your_speed_value with the desired speed
#
#	# Update the node's position using the velocity
#	position += velocity * delta
