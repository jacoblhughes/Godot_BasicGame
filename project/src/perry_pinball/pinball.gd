extends RigidBody2D
var can_launch = false
@export var starting_position_marker : Marker2D
@export var impulse_value = 8500
# Called when the node enters the scene tree for the first time.
func _ready():
	var additional_impulse_value = randi_range(-500,500)
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass


func _on_clickable_input_event(event, input_position):
	var additional_impulse_value = randi_range(-500,500)
	if event.pressed and can_launch and GameManager.get_game_enabled():
		apply_impulse(Vector2(0,-impulse_value + additional_impulse_value))
		can_launch = false
