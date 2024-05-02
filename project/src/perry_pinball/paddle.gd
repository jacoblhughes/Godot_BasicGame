extends RigidBody2D
@export var left = true

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_just_pressed("hit_space"):
		print('wow')
		apply_torque_impulse(10000)


#func _integrate_forces(state):
	#var current_rotation_degrees = rad_to_deg(rotation)
	#var new_rotation_degrees  # Convert current rotation from radians to degrees
	#if left:
		## Clamp rotation for left paddle between 60 and 120 degrees
		#new_rotation_degrees = clamp(current_rotation_degrees, 60, 120)
	#else:
		## Clamp rotation for right paddle between -30 and 30 degrees
		#new_rotation_degrees = clamp(current_rotation_degrees, -30, 30)
#
	#rotation = deg_to_rad(new_rotation_degrees)  # Convert back to radians for the physics engine

	#if Input.is_action_just_pressed("ui_accept"):
	#if left:
		#new_rotation_degrees = clamp(current_rotation_degrees, 60, 120)
	#else:
		## Clamp rotation for right paddle between -30 and 30 degrees
		#new_rotation_degrees = clamp(current_rotation_degrees, -30, 30)
