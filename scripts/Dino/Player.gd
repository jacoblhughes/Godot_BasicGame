extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var animation_player: AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_player = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if not is_on_floor():
		animation_player.play("jumping")
		velocity.y += gravity * delta
		
	if is_on_floor() and !direction:
		animation_player.play("default")  # Start the "jumping" animation
	elif is_on_floor():
		animation_player.play("walking")  # Start the "jumping" animation
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction and direction == -1 :
		velocity.x = direction * SPEED
#		animation_player.play("walking")  # Start the "jumping" animation
		animation_player.flip_h=true
	elif direction and direction == 1 :
		velocity.x = direction * SPEED
#		animation_player.play("walking")  # Start the "jumping" animation
		animation_player.flip_h=false

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)

		if("Enemy" in collision.get_collider().name):
			collision.get_collider().queue_free()
