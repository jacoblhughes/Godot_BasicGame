extends CharacterBody2D
var reset_round = false
@onready var HUDSIGNALS = get_tree().get_root().get_node("Main").get_node("HUD_SCENE")
@onready var PONGSIGNALS = get_tree().get_root().get_node("Main").get_node("GameScene").get_node("Perry").get_node("pong")
# Called when the node enters the scene tree for the first time.
var position_reset = false
var original_position = Vector2(0,0)


func _ready():
	HUDSIGNALS.startButtonPressed.connect(_on_play_button_pressed)
	HUDSIGNALS.resetButtonPressed.connect(_on_reset_button_reset_button_pressed)
	PONGSIGNALS.position_reset.connect(_on_position_reset)
	original_position = position
	reset_round = true
	pass # Replace with function body.
var collision_cooldown: float = 1.0
const COLLISION_COOLDOWN_DURATION: float = 0.2  # 0.2 seconds, adjust as needed

func _physics_process(delta):
#	print(collision_cooldown)
	if collision_cooldown > 0:
		collision_cooldown -= delta

	var collision = move_and_collide(velocity * delta)
	if collision:
		var this_collision = collision.get_collider()
		if "Paddle" in this_collision.name:	
			var collision_position = this_collision.global_position
			var collision_size = this_collision.sizeOfPaddle
			var ball_position = self.global_position
			var collision_first_y = collision_position.y
			var collision_second_y = collision_size.y+collision_first_y
			var total_range = collision_second_y-collision_first_y
			var ratio = (ball_position.y-collision_first_y)/total_range
			var third = int(ratio*3)+1
			var normal_direction = collision.get_normal().x
#			var vel = velocity.x/10
			print(third,"normal: ",normal_direction)
			var bounce_direction
			var speed_increase = 1.05
			if(third == 1):

#				var reflect = collision.get_remainder().bounce(collision.get_normal())
#				velocity = velocity.bounce(collision.get_normal())*1.1
#
#				if (normal_direction >0):
#					velocity+=Vector2(vel,-vel)
#				else:
#					velocity+=Vector2(-vel,-vel)
#				move_and_collide(reflect)
 # Calculate the new direction vector for a 45-degree angle bounce
	# Calculate the new direction vector for a 45-degree angle bounce

				if (normal_direction >0):
					bounce_direction = Vector2(1, -1).normalized()
				else:
					bounce_direction = Vector2(-1, -1).normalized()
				# Reflect the velocity along the new direction
				print(bounce_direction)
				var reflect = collision.get_remainder().bounce(bounce_direction)
				print(reflect)
				velocity = velocity.bounce(bounce_direction) * speed_increase

				move_and_collide(reflect)
				# Apply an additional velocity in the new direction
#				velocity += bounce_direction * vel
#
#				# Continue with your existing code for other thirds
#				var reflect = collision.get_remainder().bounce(collision.get_normal())
#				velocity = velocity.bounce(collision.get_normal()) * speed_increase
#				move_and_collide(bounce_direction)
			elif(third == 2):
				var reflect = collision.get_remainder().bounce(collision.get_normal())
				velocity = velocity.bounce(collision.get_normal())*speed_increase
				move_and_collide(reflect)
			else:

#				var reflect = collision.get_remainder().bounce(collision.get_normal())
#				velocity = velocity.bounce(collision.get_normal())*1.1
#				if (normal_direction >0):
#					velocity+=Vector2(vel,vel)
#				else:
#					velocity+=Vector2(-vel,vel)
#				move_and_collide(reflect)

				if (normal_direction >0):
					bounce_direction = Vector2(1, 1).normalized()
				else:
					bounce_direction = Vector2(-1, 1).normalized()
				# Reflect the velocity along the new direction
#				var reflect = collision.get_remainder().bounce(bounce_direction)
#				print(reflect)
#				velocity = velocity.bounce(bounce_direction) * speed_increase
				# Apply an additional velocity in the new direction
				velocity += bounce_direction * velocity
#
#				# Continue with your existing code for other thirds
#				var reflect = collision.get_remainder().bounce(collision.get_normal())
#				velocity = velocity.bounce(collision.get_normal()) * 1.1
				move_and_collide(velocity*delta)
		else:
			var reflect = collision.get_remainder().bounce(collision.get_normal())
			velocity = velocity.bounce(collision.get_normal())
#			move_and_collide(reflect)
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


func _on_play_button_pressed():
	if reset_round:
		reset_round = false
	pass
	
func _on_reset_button_reset_button_pressed():
	position_reset = true
	
func _on_position_reset():

	_reset_ball()

func _input(_event):

	if Input.is_action_pressed("left_mouse_click") and reset_round:

		velocity = Vector2(100,0)
		reset_round = false

func _reset_ball():
	position_reset = true
	position = original_position
	velocity = Vector2(0,0)
	position_reset = false
	reset_round = true
