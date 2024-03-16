extends CanvasLayer
	play_area_position = PlayArea.get_play_area_position_from_HUD()
	play_area_size = PlayArea.get_play_area_size_from_HUD()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_play_area_size_from_HUD():
	return %PlayArea.size
	
func get_play_area_position_from_HUD():
	return %PlayArea.global_position

func _input(event):

	if(event is InputEventMouseButton or event is InputEventScreenDrag or event is InputEventScreenTouch):
		if (
		event.position.x > play_area_position.x
		and event.position.y > play_area_position.y
		and event.position.x < (play_area_position.x + play_area_size.x)
		and event.position.y < (play_area_position.y + play_area_size.y)
		):
			in_play_area.emit(event)
