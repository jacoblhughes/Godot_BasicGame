extends RigidBody2D
class_name PerryRunFloor

const SPEED = 300.0
var direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	linear_velocity.x = SPEED * -1
	pass
