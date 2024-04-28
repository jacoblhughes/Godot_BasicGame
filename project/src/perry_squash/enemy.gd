extends CharacterBody2D
class_name PerrySquashEnemy

var speed = 100
var direction = 0
var cause_pain = false
var good_or_bad
signal enemy_squashed


# Called when the node enters the scene tree for the first time.
func _ready():
	if good_or_bad:
		cause_pain = false
		%AnimatedSprite2D.play("default")
	else:
		cause_pain = true
		%AnimatedSprite2D.play("pain")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = speed * direction
	move_and_slide()
	if %ShapeCast2D.is_colliding():
		var collider = %ShapeCast2D.get_collider(0)
		if collider is PerrySquashPlayer and cause_pain:
			collider.take_damage()
		elif collider is PerrySquashPlayer and !cause_pain:
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

