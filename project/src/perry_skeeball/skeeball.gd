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
#	print(state)
	
	if manual_move:
		print('here')
		global_position = lerp(global_position,move_to_position, .1)
	if global_position == move_to_position:
		manual_move = false
		freeze = false

func get_ready(input_position):
	freeze = true
	freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	move_to_position = input_position
	manual_move = true
	pass
