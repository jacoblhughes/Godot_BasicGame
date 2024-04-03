extends RigidBody3D
var manual_move=false
var move_to_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func _integrate_forces(state):
	if manual_move:
		state.transform.origin =  move_to_position
		manual_move = false
		if state.transform.origin.distance_to(move_to_position) < .01:
			freeze_mode = RigidBody3D.FREEZE_MODE_STATIC

func get_ready(input_position):
	manual_move = true
	freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
#	freeze= true
	move_to_position = input_position
	pass
