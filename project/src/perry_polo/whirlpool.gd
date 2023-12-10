extends Node2D
@export var whirlpoolStrength : float = 20.0
var in_whirlpool
@onready var whirlpool_area : Area2D = $Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	determine_whirlpool_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):

	if body is PerryBall:
		in_whirlpool = true
		applyWhirlpoolForce(body)

func applyWhirlpoolForce(body):
	while in_whirlpool:
		
		var direction_to_center = global_position - body.global_position
		var distance_to_center = direction_to_center.length()

		if distance_to_center > 0.001:
			var tangent = Vector2(-direction_to_center.y, direction_to_center.x).normalized()
			var force = tangent * whirlpoolStrength
			
			body.velocity += force
			await get_tree().create_timer(.25).timeout


func _on_area_2d_body_exited(body):

	if body is PerryBall:
		in_whirlpool = false
	pass # Replace with function body.

func determine_whirlpool_state():
	in_whirlpool = randf() < 0.5  # Adjust the probability as needed
	var duration = randf_range(1, 10)  # Random duration between 1 and 10 seconds
	set_whirlpools(in_whirlpool)
	await get_tree().create_timer(duration).timeout
	determine_whirlpool_state()

func set_whirlpools(flag):
		visible = flag
		whirlpool_area.monitoring = flag
