extends RigidBody3D
var manual_move=false
var move_to_position
@export var waiting_path : Path3D
var can_impulse = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func _integrate_forces(state):
	if manual_move:
		can_impulse = true
		var target_position = waiting_path.return_progress_ratio_position()
		var current_transform = state.get_transform()
		current_transform.origin = target_position
		state.set_transform(current_transform)
#	print(state.step)
#	if manual_move:
#		state.transform.origin =  move_to_position
#		manual_move = false
#		if state.transform.origin.distance_to(move_to_position) < .01:
#			freeze_mode = RigidBody3D.FREEZE_MODE_STATIC

func get_ready(input_position):
	print('here')
	manual_move = true
#	freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	set_use_custom_integrator(true)
#	freeze= true
	move_to_position = input_position
	pass


func _on_input_event(camera, event, position, normal, shape_idx):
	if manual_move and can_impulse and event is InputEventScreenTouch and event.pressed:
		set_use_custom_integrator(false)
		manual_move = false
		apply_central_impulse(Vector3(0,0,-4.5))
	pass # Replace with function body.
