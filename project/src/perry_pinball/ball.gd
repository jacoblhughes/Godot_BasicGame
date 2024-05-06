extends RigidBody2D
var can_launch = false
# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass


func _on_clickable_input_event(event, input_position):
	if event.pressed and can_launch:
		apply_impulse(Vector2(0,-5000))
		can_launch = false
