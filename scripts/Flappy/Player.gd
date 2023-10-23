extends CharacterBody2D

@onready var flappy : Node2D = get_parent().get_node("flappy")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#var velocity = Vector2(0, 0)
var acceleration = 500
var max_speed = 200
var jump_force = -400
#var gravity = 1000
var is_jumping = false
var gameRun = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
		flappy.startgame.connect(_on_start_game)

func _input(event):
		if event.is_action_pressed("left_mouse_click"):
			velocity.y = jump_force

func _physics_process(delta):
	if(gameRun):
	# Apply gravity
		velocity.y += gravity * delta

		# Limit horizontal speed
	#	velocity.x = clamp(velocity.x, -max_speed, max_speed)

		# Move the character
		move_and_slide()
	
func _on_start_game():
	gameRun = true


