extends CharacterBody2D
class_name PerrySkeeballPlayer


@export var start_position : Marker2D
const JUMP_VELOCITY = -500.0
var can_shoot = true
var target_position
var direction = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	HUD.clickable_input_event.connect(_on_clickable_input_event)

func _on_clickable_input_event(event, input_position):

	if GameManager.get_game_enabled() and event.pressed  and can_shoot:
		can_shoot = false
		%Aim.set_visible(false)
		# Calculate the directional vector based on the aim_node's rotation.
		var angle = %Aim.rotation_degrees  + 90
		var direction = Vector2(cos(angle * PI / 180.0), sin(angle * PI / 180.0))

		# Apply the directional vector with the jump velocity to the player's velocity.
		velocity.x = direction.x * JUMP_VELOCITY
		velocity.y = direction.y * JUMP_VELOCITY

		#target_position = input_position

func _physics_process(delta):
	if GameManager.get_game_enabled():
		move_and_slide()
		#var adjusted_direction = (target_position - global_position).normalized()
		#$Aim.rotation = adjusted_direction.angle() - rotation
		#
		%Aim.rotation_degrees += 50 * delta * direction
		if %Aim.rotation_degrees >= 45 and direction == 1:
			direction = -1
		elif %Aim.rotation_degrees <= -45 and direction == -1:
			direction = 1
		pass


func shoot_straight():
	var magnitude = velocity.length()
	velocity.y = -magnitude
	velocity.x = 0

func reset_position():
	velocity = Vector2.ZERO
	%Aim.set_visible(false)
	position = start_position.position
	%Aim.set_visible(true)
	can_shoot = true
