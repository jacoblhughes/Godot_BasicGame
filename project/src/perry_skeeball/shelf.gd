extends Node3D

signal load_ball
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_load_input_event(camera, event, position, normal, shape_idx):
	load_ball.emit(event,position)
	pass # Replace with function body.
