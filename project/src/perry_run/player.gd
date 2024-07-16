extends CharacterBody2D
class_name PerryRunPlayer

const JUMP_VELOCITY = 800.0
const MAX_FLY_TIME = .3
var base_gravity :int = 3500
var gravity : int
var fly_time = 0.0
var xpos
var should_jump
var jump_scale
var flying : bool
@export var jump_height: float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float


@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _ready():
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	
	gravity = base_gravity
	pass

func _on_clickable_input_event(event, input_position):
	if event.is_pressed():
		should_jump = true
	else:
		should_jump = false

func _physics_process(delta):
	velocity.x = 0
	
	if is_on_floor():
		fly_time = 0.0

	if not is_on_floor() and motion_mode == 0:
		velocity.y += get_gravity() * delta

	if should_jump and is_on_floor():
		AudioManager.play_sound("perry_run_jump")
		jump()

	if should_jump and not is_on_floor() and fly_time < MAX_FLY_TIME and GameManager.get_game_enabled() and motion_mode == 0:
		print('flying')
		flying = true
		fly_time += delta
	else:
		flying = false
		
	move_and_slide()
	position.x = clamp(position.x, xpos, xpos)  # Keep the player at xpos
	
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else (fall_gravity / 10 if should_jump else fall_gravity)
	
func jump():
	velocity.y = jump_velocity
	
func set_xpos(pos):
	xpos = pos

func set_yatio(val):
	jump_scale = val

func set_collision_disabled(val):
	%CollisionShape2D.disabled = val
