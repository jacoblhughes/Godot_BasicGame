extends Node3D

signal cover_input
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func return_start_position():
	return %Marker3D.global_position


func _on_cover_input_event(camera, event, position, normal, shape_idx):
	cover_input.emit(event,position)
	pass # Replace with function body.
