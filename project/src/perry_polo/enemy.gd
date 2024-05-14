extends CharacterBody2D

@export var ball : CharacterBody2D
@export var enemy_start : Marker2D

var original_speed = 1.25
var speed

var sprite_half_y


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = original_speed
	sprite_half_y= return_size().y/4
	get_parent().position_reset.connect(_on_position_reset)
	pass # Replace with function body.



func _physics_process(_delta):

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
	global_position.x = clamp(global_position.x, enemy_start.global_position.x,enemy_start.global_position.x)

func _on_position_reset():
	global_position.y = enemy_start.global_position.y
	pass

func return_size():
	return %Sprite2D.get_rect().size
