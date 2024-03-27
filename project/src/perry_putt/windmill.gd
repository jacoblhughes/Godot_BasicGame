extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_activation_area_body_entered(body):
	print(body)
	if body is PerryPuttFan:
		print('yes')
		body.activate_collision()
	pass # Replace with function body.


func _on_activation_area_body_exited(body):
	print('no')
	if body is PerryPuttFan:
		body.deactivate_collision()
	pass # Replace with function body.
