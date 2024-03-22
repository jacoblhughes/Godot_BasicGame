extends RigidBody2D

@export var clickable_area : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():

	clickable_area.clickable_input_event.connect(_on_clickable_input)
#	apply_impulse(Vector2(200,170)*5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hide_arrow():
	%Aim.visible = false

func show_arrow():
	%Aim.visible = true

func _on_clickable_input(event,input_position):
	if GameManager.get_game_enabled():
		if event is InputEventMouseButton:
			var direction = (input_position - global_position).normalized()
			rotation = atan2(direction.y, direction.x)
