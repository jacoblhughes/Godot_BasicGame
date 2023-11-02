extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_maze_body_exited(body):
	_out_of_bounds()
	pass # Replace with function body.

func _on_melt_zone_body_entered(body):
	_out_of_bounds()
	pass # Replace with function body.

func _out_of_bounds():
	print('CRASH')
