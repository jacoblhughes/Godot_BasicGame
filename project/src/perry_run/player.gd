extends CharacterBody2D
class_name PerryRunPlayer


const JUMP_VELOCITY = -600.0
const MAX_JUMP_TIME = 0.2  # Maximum time the jump button can be held
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_time = 0.0  # Time for which the jump button is held

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not $RayCast2D.is_colliding():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and $RayCast2D.is_colliding():
		velocity.y = JUMP_VELOCITY
		jump_time = 0  # Start counting jump time
#
	# Check if jump button is held
	elif Input.is_action_pressed("ui_accept") and not $RayCast2D.is_colliding() and jump_time < MAX_JUMP_TIME:
		jump_time += delta
		velocity.y -= 20  # This value controls the additional jump force per frame



	move_and_slide()
