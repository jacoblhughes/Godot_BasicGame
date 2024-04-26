extends RigidBody2D
class_name PerrySquashEnemy

var speed = 100
var direction = 0
signal enemy_squashed
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity.x = speed * direction
	pass

func _on_body_entered(body):
	print(body)
	if body is PerrySquashPlayer:
		enemy_squashed.emit()
