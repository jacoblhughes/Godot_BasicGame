extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 15
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 30
var target_velocity = Vector3.ZERO
@export var bounce_impulse = 16
@onready var ray_cast : RayCast3D = get_node("RayCast3D")
signal hit
func _physics_process(delta):
	var ray_cast_collision = ray_cast.get_collider()
	if ray_cast_collision:
		print(ray_cast.get_collision_point())
	
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Jumping.
	if is_on_floor() and Input.is_action_just_pressed("hit_space"):
		target_velocity.y = jump_impulse
	
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)

		# If the collision is with ground
		if collision.get_collider() == null:
			continue

		# If the collider is with a mob
		if collision.get_collider().is_in_group("enemy"):

			var mob = collision.get_collider()
			# we check that we are hitting it from above.
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				# If so, we squash it and bounce.
				mob.squash()
				target_velocity.y = bounce_impulse
				# Prevent further duplicate calls.
				break	
	# Moving the Character
	velocity = target_velocity
	
	move_and_slide()
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func _on_mob_detector_body_entered(body):
	print(body)
	die()
# And this function at the bottom.
func die():
	hit.emit()
	queue_free()



