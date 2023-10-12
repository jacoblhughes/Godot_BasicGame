extends CharacterBody2D

@onready var ball : CharacterBody2D
@onready var my_sprite : ColorRect
var lag_timer = 0.0
var lag_duration = 0.5  # Adjust this value to control the lag duration
var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $ColorRect
	ball = get_parent().get_node("Ball")
#	position.y = clamp(position.y,0,HUDVariables.PlayArea.position.y)
	pass # Replace with function body.



func _physics_process(delta):

	# Get the current position of the ball
	var ball_position = ball.position

	# Calculate the direction to move the paddle based on the ball's position
	var direction = 0
	if ball_position.y < position.y:
		direction = -1  # Move up
	elif ball_position.y > position.y:
		direction = 1   # Move down

	# Move the paddle
	var paddle_velocity = Vector2(0, direction * speed)
	var collision = move_and_collide(paddle_velocity)
	if collision:
		# A collision occurred, set velocity to zero to prevent movement
		velocity = Vector2(0, 0)
	position.y = clamp(position.y, HUDVariables.PlayArea.global_position.y + my_sprite.size.y/2,HUDVariables.PlayArea.global_position.y+HUDVariables.PlayArea.size.y - my_sprite.size.y/2)


