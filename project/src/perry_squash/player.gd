extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 10
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 25
var target_velocity = Vector3.ZERO
@export var bounce_impulse = 16

signal hit

# Swipe detection variables
var start_swipe_pos = Vector2.ZERO
var end_swipe_pos = Vector2.ZERO
var is_swiping = false
# New variable for touch start time
var touch_start_time = 0
# Threshold in seconds to differentiate between click and swipe
var click_threshold = .01
# Threshold in pixels to differentiate between click and swipe
var swipe_threshold = 10
func _ready():
	# Existing setup code...
	Input.set_use_accumulated_input(true)
	GameManager.in_play_area.connect(_on_in_play_area)

func _on_in_play_area(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			start_swipe_pos = event.position
			touch_start_time = Time.get_ticks_msec() / 1000.0 # Get current time in seconds
			is_swiping = true
		else:
			is_swiping = false
			end_swipe_pos = event.position
			var touch_duration = Time.get_ticks_msec() / 1000.0 - touch_start_time
			var touch_distance = end_swipe_pos.distance_to(start_swipe_pos)

			if touch_duration < click_threshold and touch_distance < swipe_threshold:
				handle_click()
			else:
				handle_swipe()

func handle_click():
	if is_on_floor():
		target_velocity.y = jump_impulse
		
func handle_swipe():
	var swipe_direction = (end_swipe_pos - start_swipe_pos).normalized()
	# Convert 2D swipe direction to 3D movement
	var direction_3D = Vector3(swipe_direction.x, 0, swipe_direction.y)
	move_character(direction_3D)

func move_character(direction: Vector3):
	if direction != Vector3.ZERO:
		$Pivot.look_at(position + direction, Vector3.UP)
		$AnimationPlayer.speed_scale = 4
		# Set the target velocity based on swipe direction
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
	else:
		$AnimationPlayer.speed_scale = 1

#func _on_in_play_area(event):
#	if event is InputEventScreenTouch:
#		if event.pressed:
#			start_swipe_pos = event.position
#			is_swiping = true
#		else:
#			is_swiping = false
#			end_swipe_pos = event.position
#			handle_swipe()


func _physics_process(delta):
	
#	var direction = Vector3.ZERO
#
#	if Input.is_action_pressed("move_right"):
#		direction.x += 1
#	if Input.is_action_pressed("move_left"):
#		direction.x -= 1
#	if Input.is_action_pressed("move_down"):
#		direction.z += 1
#	if Input.is_action_pressed("move_up"):
#		direction.z -= 1
#
#	if direction != Vector3.ZERO:
#		direction = direction.normalized()
#		$Pivot.look_at(position + direction, Vector3.UP)
#		$AnimationPlayer.speed_scale = 4
#	else:
#		$AnimationPlayer.speed_scale = 1
#	# Ground Velocity
#	target_velocity.x = direction.x * speed
#	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Jumping.
	if is_on_floor() and Input.is_action_just_pressed("left_mouse_click"):
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

	die()
# And this function at the bottom.
func die():
	hit.emit()
	queue_free()



