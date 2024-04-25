extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var moving_speed = 100
var slam_speed = 400
var is_slamming = false

func _ready():
	# Initial back and forth movement setup can be done using an AnimationPlayer or manually here
	pass

func _physics_process(delta):
	if !is_slamming:
		# Logic for moving back and forth
		position.x += moving_speed * delta
		if position.x > get_viewport_rect().size.x or position.x < 0:
			moving_speed = -moving_speed  # Change direction
	else:
		# Slamming down logic
		velocity.y += slam_speed * delta
		move_and_slide()

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		# When the player presses a button (e.g., space bar)
		is_slamming = true
