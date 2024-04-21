extends AnimatableBody2D
class_name PerryRunFloor

const SPEED = 5
var direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	position.x += SPEED * -1
	pass

func set_color(val):
	if val == true:
		%ColorRect.color = Color.RED
