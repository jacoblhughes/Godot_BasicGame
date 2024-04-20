extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_exited.connect(_on_body_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_exited(body):
	if body is PerryRunFloor:
		body.queue_free()
	pass # Replace with function body.
