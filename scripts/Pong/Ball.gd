extends RigidBody2D
var reset_round = false
@onready var HUDSIGNALS = get_tree().get_root().get_node("Main").get_node("HUD_SCENE")
# Called when the node enters the scene tree for the first time.
var position_reset = false
var original_position = Vector2(0,0)
func _ready():
	HUDSIGNALS.startButtonPressed.connect(_on_play_button_pressed)
	HUDSIGNALS.resetButtonPressed.connect(_on_reset_button_reset_button_pressed)
	original_position = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state):
	if position_reset:

		state.transform.origin = original_position
		state.linear_velocity = Vector2(0,0)
		position_reset = false
	else:

		pass

func _on_play_button_pressed():
	linear_velocity = Vector2(-100,-100)

func _on_reset_button_reset_button_pressed():
	position_reset = true
	
func _on_body_entered(body):
	print("Ball hit: ",body.name)
	if body.name == "Paddle - Computer" or body.name == "Paddle - Player":
		linear_velocity = linear_velocity.normalized() * (linear_velocity.length() * 1.20)
	if body.name == "Paddle - Computer":
		linear_velocity = Vector2(100,100)
	if body.name == "Win":
		position_reset = true
		HUDSIGNALS.set_new_score(1)
		reset_round = true
	if body.name == "Win":
		position_reset = true
		HUDSIGNALS.set_new_score(-1)
		reset_round = true

func _input(event):

	if Input.is_action_pressed("left_mouse_click") and reset_round:
		linear_velocity = Vector2(-100,-100)
		reset_round = false
