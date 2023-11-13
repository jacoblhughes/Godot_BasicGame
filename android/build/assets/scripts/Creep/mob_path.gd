extends Path2D

func _ready():
	var curve = Curve2D.new() # Create a new Curve2D resource
	var play_area_position = GameManager.get_play_area_position_from_HUD()
	var play_area_size = GameManager.get_play_area_size_from_HUD()

	# Add points to the curve
	curve.add_point(play_area_position)     # Start point
	curve.add_point(Vector2(play_area_position.x + play_area_size.x,play_area_position.y))  # Middle point
	curve.add_point(Vector2(play_area_position.x + play_area_size.x,play_area_position.y  + play_area_size.y))  # Middle point
	curve.add_point(Vector2(play_area_position.x,play_area_position.y  + play_area_size.y))  # Middle point

	curve.add_point(play_area_position)     # Start point
	# Assign the curve to the Path2D's curve property
	self.curve = curve

func _process(delta):
	pass
