extends Paddle

@export var ball : CharacterBody2D


var original_speed = .6
var speed
var original_position_y
var sprite_half_y
var original_position_x
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = original_speed
	sprite_half_y= return_size().y/4
	original_position_y = global_position.y
	original_position_x = global_position.x
	get_parent().position_reset.connect(_on_position_reset)
	pass # Replace with function body.



func _physics_process(_delta):

	global_position.x = original_position_x
	# Get the current position of the ball
	var ball_position = ball.global_position

	# Calculate the direction to move the paddle based on the ball's position
	var direction = 0
	if ball_position.y < global_position.y:
		direction = -1  # Move up
	elif ball_position.y > global_position.y:
		direction = 1   # Move down

	# Move the paddle
	var paddle_velocity = Vector2(0, direction * speed)
	var collision = move_and_collide(paddle_velocity)
	if collision:
		velocity = Vector2(0, 0)
	global_position.y = clamp(global_position.y, HUD.get_play_area_position().y + sprite_half_y,HUD.get_play_area_position().y+ HUD.get_play_area_size().y - sprite_half_y)

func _on_position_reset():
	global_position.y = original_position_y
	pass

func return_size():
	return %Sprite2D.get_rect().size
