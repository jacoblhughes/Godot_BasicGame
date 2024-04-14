extends RigidBody3D
class_name PerrySkeeball
var manual_move=false
var move_to_position
@export var waiting_path : Path3D
var can_impulse = false

signal remove_ball

# Called when the node enters the scene tree for the first time.
func _ready():
#	disable_collision()
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

func get_ready(input_position):
	manual_move = true
#	freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	set_use_custom_integrator(true)
#	freeze= true
	move_to_position = input_position
	pass


func shoot():
	if manual_move and can_impulse:
		set_use_custom_integrator(false)
		manual_move = false
		apply_central_impulse(Vector3(0,0,-5))
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited():
	dead_ball()
	pass # Replace with function body.

func dead_ball():
	remove_ball.emit()
	queue_free()
