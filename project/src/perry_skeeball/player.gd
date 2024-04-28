extends CharacterBody2D
class_name PerrySkeeballPlayer

@export var aim_node : Control
@export var start_position : Marker2D
const JUMP_VELOCITY = -500.0
var can_shoot = true
# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	HUD.clickable_input_event.connect(_on_clickable_input_event)

func _on_clickable_input_event(event, input_position):
	if event.pressed and GameManager.get_game_enabled() and can_shoot:
		can_shoot = false
		aim_node.set_visible(false)
		# Calculate the directional vector based on the aim_node's rotation.
		var angle = aim_node.rotation_degrees  + 90
		var direction = Vector2(cos(angle * PI / 180.0), sin(angle * PI / 180.0))

		# Apply the directional vector with the jump velocity to the player's velocity.
		velocity.x = direction.x * JUMP_VELOCITY
		velocity.y = direction.y * JUMP_VELOCITY

func _physics_process(delta):
	if GameManager.get_game_enabled():
		move_and_slide()

func shoot_straight():
	var magnitude = velocity.length()
	velocity.y = -magnitude
	velocity.x = 0

func reset_position():
	velocity = Vector2.ZERO
	aim_node.set_visible(false)
	position = start_position.position
	aim_node.set_visible(true)
	can_shoot = true
