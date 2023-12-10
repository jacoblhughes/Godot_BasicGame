extends Node2D
@export var whirlpoolStrength : float = 20.0
var in_whirlpool
@onready var whirlpool_area : Area2D = $Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	
#	whirlpool_area = $Area2D
	print('whirlpool')
	pass # Replace with function body.

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
			var force = (direction_to_center / distance_to_center).normalized() * whirlpoolStrength

			body.velocity += force
			await get_tree().create_timer(.25).timeout


func _on_area_2d_body_exited(body):

	if body is PerryBall:
		in_whirlpool = false
	pass # Replace with function body.
