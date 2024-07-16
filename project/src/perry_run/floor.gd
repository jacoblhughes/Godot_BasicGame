extends AnimatableBody2D
class_name PerryRunFloor

@export var base_speed : float
var speed : float
var direction44

@export var animation : AnimatedSprite2D

func _physics_process(delta):
	position.x += speed * -1 * delta
	pass

func animate():
	if animation.sprite_frames.has_animation("default"):
		animation.play('default')
	pass
