extends CharacterBody2D
class_name PerrySkeeballPlayer

@export var start_position : Marker2D
const JUMP_VELOCITY = -500.0
var can_shoot = true
var direction_set = false
var target_position

func _ready():
	HUD.clickable_input_event.connect(_on_clickable_input_event)

func _on_clickable_input_event(event, input_position):
	if GameManager.get_game_enabled() and event.pressed:

		if can_shoot and not direction_set:
			# Set the direction
			direction_set = true
			target_position = input_position
			var angle = global_position.angle_to_point(target_position)
			%Aim.rotation_degrees = rad_to_deg(angle)

		elif direction_set:
			# Shoot the ball
			can_shoot = false
			direction_set = false
			%Aim.set_visible(false)
			var angle = global_position.angle_to_point(target_position) + PI
			var direction_vector = Vector2(cos(angle), sin(angle))
			velocity.x = direction_vector.x * JUMP_VELOCITY
			velocity.y = direction_vector.y * JUMP_VELOCITY
			AudioManager.play_sound("perry_skeeball_rolling")
func _physics_process(delta):
	if GameManager.get_game_enabled():
		move_and_slide()

func shoot_straight():
	var magnitude = velocity.length()
	velocity.y = -magnitude
	velocity.x = 0
	AudioManager.play_sound("perry_skeeball_fling")
func reset_position():
	velocity = Vector2.ZERO
	%Aim.set_visible(false)
	position = start_position.position
	%Aim.set_visible(true)
	can_shoot = true
	direction_set = false
