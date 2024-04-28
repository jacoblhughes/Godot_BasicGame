extends Node2D

@export var left_bound : Marker2D
@export var right_bound : Marker2D
# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("initialize_bounds")

	pass # Replace with function body.

func initialize_bounds():
	var left_pos = left_bound.position

	var right_pos = right_bound.position
	print(right_pos)
	for node in get_children():
		node.set_left_and_right_bound(left_pos,right_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
