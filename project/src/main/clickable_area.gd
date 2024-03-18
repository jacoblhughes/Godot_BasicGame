extends Node2D
var is_touching = false
var target_position
signal clickable_input_event

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print(event)
		if event.pressed:
			is_touching = true
			target_position = get_global_mouse_position()
			clickable_input_event.emit(target_position)
		else:
			is_touching = false

#		# Check for touch drag events
#	elif event is InputEventScreenDrag and is_touching:
#		target_position = get_global_mouse_position()

	pass # Replace with function body.

func get_play_area_size():
	return %CollisionShape2D.shape.size
	
	
func get_play_area_position():
	return %Area2D.global_position - Vector2(%CollisionShape2D.shape.size.x/2,%CollisionShape2D.shape.size.y/2)
	
