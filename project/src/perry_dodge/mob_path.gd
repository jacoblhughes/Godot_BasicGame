extends Path2D
@export var clickable_area : Node2D
#@onready var area_shape : Area2D =  %Area2D
#@onready var collision_shape :CollisionShape2D =  %CollisionShape2D
func _ready():
	pass
	var curve = Curve2D.new() # Create a new Curve2D resource
	var play_area_position = clickable_area.get_play_area_position()
	var play_area_size = clickable_area.get_play_area_size()

	# Add points to the curve
	curve.add_point(play_area_position)     # Start point
	curve.add_point(Vector2(play_area_position.x + play_area_size.x,play_area_position.y))  # Middle point
	curve.add_point(Vector2(play_area_position.x + play_area_size.x,play_area_position.y  + play_area_size.y))  # Middle point
	curve.add_point(Vector2(play_area_position.x,play_area_position.y  + play_area_size.y))  # Middle point

	curve.add_point(play_area_position)     # Start point
	# Assign the curve to the Path2D's curve property
	self.curve = curve
