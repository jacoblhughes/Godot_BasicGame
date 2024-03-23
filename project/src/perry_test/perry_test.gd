extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func _on_area_2d_input_event(viewport, event, shape_idx):

#		# Check for touch drag events
#	elif event is InputEventScreenDrag and is_touching:
#		target_position = get_global_mouse_position()

	pass # Replace with function body.

func _on_wow_zone_input_event(viewport, event, shape_idx):
	print(event)
	if event is InputEventMouseButton or event is InputEventScreenDrag:
		if event is InputEventMouseButton:
			var target_position = get_global_mouse_position()
#			clickable_input_event.emit(event, target_position)
		else:
			pass
	pass # Replace with function body.
