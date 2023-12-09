extends Node2D
@export var whirlpoolStrength : float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print(body)
	if body is PerryBall:
		applyWhirlpoolForce(body)

func applyWhirlpoolForce(body):
	var direction_to_center = global_position - body.global_position
	var distance_to_center = direction_to_center.length()

	if distance_to_center > 0.001:
		var force = (direction_to_center / distance_to_center) * whirlpoolStrength
		print(direction_to_center)
#		body.move_and_slide(force, Vector2.ZERO, false)
