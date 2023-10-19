extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var new_position
# Get the gravity from the project settings to be synced with RigidBody nodes.

var screen_size = HUDVariables.get_play_area_size_from_HUD()
var screen_position = HUDVariables.get_play_area_position_from_HUD()
func _ready():
	
	pass

func start(new_position):
	position = new_position

func _physics_process(delta):
	
	velocity=Vector2(0,0)
	# Add the gravity.
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("move_up"):
		velocity.y = -SPEED
	if Input.is_action_pressed("move_down"):
		velocity.y = SPEED
	move_and_slide()
	position = position.clamp(screen_position, screen_position+screen_size)	
