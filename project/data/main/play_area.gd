extends CanvasLayer
signal in_play_area(event)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_play_area_size():
	return %PlayArea.size
	
func get_play_area_position():
	return %PlayArea.global_position

func _input(event):

	if(event is InputEventMouseButton or event is InputEventScreenDrag or event is InputEventScreenTouch):
		if (
		event.position.x > %PlayArea.global_position.x
		and event.position.y > %PlayArea.global_position.y
		and event.position.x < (%PlayArea.size.x + %PlayArea.size.x)
		and event.position.y < (%PlayArea.size.y + %PlayArea.size.y)
		):
			in_play_area.emit(event)
