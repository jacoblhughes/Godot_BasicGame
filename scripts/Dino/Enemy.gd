extends CharacterBody2D


const SPEED = 200.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#	print(position.x)
	# Handle Jump.
	velocity.x = -1 * SPEED
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)

		if(collision.get_collider().name != "Floor"):
			print(collision.get_collider().name)
	
	
	
	
	

#	velocity.x = -1 * SPEED
#	var collision = move_and_slide()
#	print(collision.name)

#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		var reflect = collision.get_remainder().bounce(collision.get_normal())
#		velocity = velocity.bounce(collision.get_normal())*1.1
#		move_and_collide(reflect)
#
#	move_and_slide()
#	for i in range(get_slide_collision_count()):
#		# Check if cooldown is active
#		if collision_cooldown > 0:
#			continue
#
#		var collision = get_slide_collision(i)
#
#		if(collision.get_collider().name == "Top Wall" or collision.get_collider().name == "Paddle - Computer"):
#			var normal = collision.get_remainder().bounce(collision.get_normal())
#			print(normal)
#			print("Top Wall: ")
#			velocity = velocity.bounce(normal)
#			print(velocity)
