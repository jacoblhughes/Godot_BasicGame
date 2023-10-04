extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


func _on_left_wall_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print(body)
	pass # Replace with function body.


func _on_left_wall_body_entered(body):

	print(body)
	pass # Replace with function body.


func _on_ball_body_entered(body):

	print(body)
	pass # Replace with function body.


func _on_ball_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):

	print(body_rid, body, body_shape_index, local_shape_index)
	pass # Replace with function body.
