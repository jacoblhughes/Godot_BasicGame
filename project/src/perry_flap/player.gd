extends CharacterBody2D
class_name PerryFlapPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#var velocity = Vector2(0, 0)
var acceleration = 500
var max_speed = 200
var jump_force = -400
#var gravity = 1000
var is_jumping = false
var gameRun = false
signal flappy_hit
var went_up = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animated_sprite : AnimatedSprite2D

func _ready():
	Interruptions.glitch_switch.connect(_on_glitch_switch)
	animated_sprite = get_node("AnimatedSprite2D")
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	%TweetTimer.timeout.connect(_on_tweet_timeout)
	%TweetTimer.start()
	pass

func _on_clickable_input_event(event, input_position):

	if GameManager.get_game_enabled() and event.pressed:
		went_up = true
		AudioManager.play_sound("perry_flap_flap")
		velocity.y = jump_force
		animated_sprite.play("up")  # Play "up" animation when clicked

func hit():
	if(GameManager.get_game_enabled()):
		HUD.update_lives()

func _physics_process(delta):
	if GameManager.get_game_enabled():
		# Apply gravity
		velocity.y += gravity * delta
		if velocity.y > 0 and went_up:
			animated_sprite.play("down")  # Play "down" animation when falling
			went_up = false
		# Limit horizontal speed
		# velocity.x = clamp(velocity.x, -max_speed, max_speed)
		# Limit horizontal speed
	#	velocity.x = clamp(velocity.x, -max_speed, max_speed)

		# Move the character
		move_and_slide()
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)

			if("Enemy" in collision.get_collider().name):
				self.collision_mask = 0  # This will disable the player's ability to detect enemies (or anything else, for that matter).
#				collision.get_collider().queue_free()

				flappy_hit.emit()

#		global_position = global_position.lerp(target_position, lerp_speed)
		global_position.x = clamp(global_position.x, HUD.get_play_area_position().x,HUD.get_play_area_position().x+HUD.get_play_area_size().x)
		global_position.y = clamp(global_position.y, HUD.get_play_area_position().y,HUD.get_play_area_position().y+HUD.get_play_area_size().y)

	else:
		velocity.y = 0

func _on_tweet_timeout():
	var new_wait_time = randi_range(5,10)
	%TweetTimer.wait_time = new_wait_time

	AudioManager.play_sound("perry_flap_tweet")
	%TweetTimer.start()

func _on_glitch_switch(val):
	if val:
		gravity *= -1
		jump_force *=-1
		self.scale.y = -1
	else:
		gravity *= -1
		jump_force *=-1
		self.scale.y = 1
