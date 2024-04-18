extends CharacterBody3D

# How fast the player moves in meters per second.
var current_speed
@export var ground_speed = 10
@export var air_speed = 2
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 30
var target_velocity = Vector3.ZERO
@export var bounce_impulse = 16
@export var air_damping = 0.25  # Air damping factor
signal hit
var jumped = false
# Swipe detection variables
var start_swipe_pos = Vector2.ZERO
var end_swipe_pos = Vector2.ZERO
var is_swiping = false
# New variable for touch start time
var touch_start_time = 0
# Threshold in seconds to differentiate between click and swipe
var click_threshold = 1
# Threshold in pixels to differentiate between click and swipe
var swipe_threshold = 10
var movement_direction = Vector3.ZERO  # Direction from swipes
var can_move = false
func _ready():
	# Existing setup code...

	Input.set_use_accumulated_input(true)
	HUD.clickable_input_event.connect(_on_clickable_input_event)

func _on_clickable_input_event(event, input_position):

	if GameManager.get_game_enabled() and can_move:

		if event is InputEventScreenTouch:
			if event.pressed:

				start_swipe_pos = input_position
				touch_start_time = Time.get_ticks_msec() / 1000.0 # Get current time in seconds
				is_swiping = true
			else:

				is_swiping = false
				end_swipe_pos = input_position
				var touch_duration = (Time.get_ticks_msec() / 1000.0) - touch_start_time
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
	# Store the 3D movement direction based on swipe
	movement_direction = Vector3(swipe_direction.x, 0, swipe_direction.y)

func _physics_process(delta):
	var current_speed = ground_speed if is_on_floor() else air_speed

	# Update target velocity based on movement direction and current speed
	target_velocity.x = movement_direction.x * current_speed
	target_velocity.z = movement_direction.z * current_speed

	# Handle vertical movement and jumping
	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta
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
	# Apply the movement
	velocity = target_velocity
	move_and_slide()
	# Update character rotation and other properties
	if movement_direction != Vector3.ZERO:
		$Pivot.look_at(global_transform.origin + movement_direction, Vector3.UP)
	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

func _on_mob_detector_body_entered(body):
	die()
# And this function at the bottom.
func die():
	hit.emit()
	queue_free()

func allow_move(flag):
	can_move = flag


func _on_visible_on_screen_notifier_3d_screen_exited():
	die()
	pass # Replace with function body.
