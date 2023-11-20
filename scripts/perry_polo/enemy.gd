extends CharacterBody2D

@onready var ball : CharacterBody2D
@onready var my_sprite : Sprite2D
@export var sizeOfPaddle : Vector2
@onready var PONGSIGNALS = get_parent().get_node("PerryPolo")
var lag_timer = 0.0
var lag_duration = 0.5  # Adjust this value to control the lag duration
var speed = 1
var original_position_y
var sprite_half_y
# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $Sprite2D
	ball = get_parent().get_node("Ball")
	sizeOfPaddle = my_sprite.get_rect().size
	sprite_half_y= sizeOfPaddle.y/2
	original_position_y = position.y+sprite_half_y
	PONGSIGNALS.position_reset.connect(_on_position_reset)
	pass # Replace with function body.



func _physics_process(_delta):

	# Get the current position of the ball
	var ball_position = ball.global_position

	# Calculate the direction to move the paddle based on the ball's position
	var direction = 0
	if ball_position.y - sprite_half_y/2 < global_position.y:
		direction = -1  # Move up
	elif ball_position.y - sprite_half_y/2 > global_position.y:
		direction = 1   # Move down

	# Move the paddle
	var paddle_velocity = Vector2(0, direction * speed)
	var collision = move_and_collide(paddle_velocity)
	if collision:
		# A collision occurred, set velocity to zero to prevent movement
		velocity = Vector2(0, 0)
	position.y = clamp(position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y - sprite_half_y)


func _on_position_reset():
	global_position.y = original_position_y - sprite_half_y
	pass
