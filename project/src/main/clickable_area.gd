extends Node2D

var target_position
signal clickable_input_event

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	print(event)
	if event is InputEventMouseButton or event is InputEventScreenDrag:
		if event is InputEventMouseButton:
			target_position = get_global_mouse_position()
			clickable_input_event.emit(event, target_position)
		else:
			pass
#		# Check for touch drag events
#	elif event is InputEventScreenDrag and is_touching:
#		target_position = get_global_mouse_position()

	pass # Replace with function body.

func get_play_area_size():
	return %CollisionShape2D.shape.size
	
	
func get_play_area_position():
	return %Area2D.global_position - Vector2(%CollisionShape2D.shape.size.x/2,%CollisionShape2D.shape.size.y/2)
