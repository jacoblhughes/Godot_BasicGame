extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(50, 100))
	var result = space_state.intersect_ray(query)
#	print(result)
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
	else:
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
