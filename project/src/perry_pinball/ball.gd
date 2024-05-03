extends RigidBody2D
var can_launch = false
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("hit_space") and can_launch:
		apply_impulse(Vector2(0,-5000))
		can_launch = false
	pass


