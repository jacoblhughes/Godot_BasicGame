extends RigidBody2D
@export var left = true
var factor

func _ready():
	if left:
		factor = 1
	else:
		factor = -1
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	pass # Replace with function body.

func _on_clickable_input_event(event, _input_position):
	if GameManager.get_game_enabled():
		
		if event.pressed:
			apply_impulse(Vector2(0,2000 * -factor),%Marker2D.global_position)
		if !event.pressed:
			apply_impulse(Vector2(0,2000 * factor),%Marker2D.global_position)
	

func _physics_process(delta):
	pass
	#if Input.is_action_just_pressed("hit_space"):
		#apply_impulse(Vector2(0,2000 * -factor),%Marker2D.global_position)
	#elif Input.is_action_just_released("hit_space"):
		#apply_impulse(Vector2(0,2000 * factor),%Marker2D.global_position)


func _integrate_forces(state):
	var current_rotation_degrees = rad_to_deg(rotation)
	var new_rotation_degrees  # Convert current rotation from radians to degrees
	if left:
		new_rotation_degrees = clamp(current_rotation_degrees, 60, 120)
	else:
		new_rotation_degrees = clamp(current_rotation_degrees, -30, 30)
#
	rotation = deg_to_rad(new_rotation_degrees)  # Convert back to radians for the physics engine
