extends AnimatableBody2D
class_name PerryRunFloor

var speed = 5
var direction

func _physics_process(delta):
	position.x += speed * -1 * delta
	pass
