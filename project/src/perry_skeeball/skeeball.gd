extends RigidBody3D
var manual_move=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
#	print(state)
	pass
#	if manual_move:
#		print('here')
#		%Skeeball.global_position = lerp(%Skeeball.global_position,%StartingArea.return_start_position(), .1)


func _on_mouse_entered():
	print('mouse')
	pass # Replace with function body.
