extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	pass

func _physics_process(_delta):
	velocity.x = -.75 * SPEED
	move_and_slide()
	var last_collision = get_last_slide_collision()

	if last_collision and last_collision.get_collider() is PerryFlapPlayer:
		last_collision.get_collider().hit()
