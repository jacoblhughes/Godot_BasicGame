extends Path2D
#@onready var area_shape : Area2D =  %Area2D
#@onready var collision_shape :CollisionShape2D =  %CollisionShape2D
func _ready():
	pass
#	var curve = Curve2D.new() # Create a new Curve2D resource
#	var play_area_position = area_shape.global_position
#	var play_area_size = collision_shape.shape.size
#
#	# Add points to the curve
#	curve.add_point(play_area_position)     # Start point
#	curve.add_point(Vector2(play_area_position.x + play_area_size.x,play_area_position.y))  # Middle point
#	curve.add_point(Vector2(play_area_position.x + play_area_size.x,play_area_position.y  + play_area_size.y))  # Middle point
#	curve.add_point(Vector2(play_area_position.x,play_area_position.y  + play_area_size.y))  # Middle point
#
#	curve.add_point(play_area_position)     # Start point
#	# Assign the curve to the Path2D's curve property
#	self.curve = curve
