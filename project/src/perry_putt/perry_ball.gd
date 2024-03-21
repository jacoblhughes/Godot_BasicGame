extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2).timeout
	apply_impulse(Vector2(200,170)*5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
