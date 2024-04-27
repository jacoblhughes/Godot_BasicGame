extends CharacterBody2D
class_name PerrySquashEnemy

var speed = 100
var direction = 0
signal enemy_squashed
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = speed * direction
	move_and_slide()
	if %ShapeCast2D.is_colliding():
		var collider = %ShapeCast2D.get_collider(0)
		if collider is PerrySquashPlayer:

			enemy_squashed.emit()
			die()
	pass

func die():
	queue_free()

func set_direction(val):
	if val == 1:
		direction = 1
		%AnimatedSprite2D.flip_h = true
	elif val == -1:
		direction = -1

