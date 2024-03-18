extends CharacterBody2D
class_name PlayerFlappy
@onready var flappy : Node2D = get_parent().get_node("PerryFlap")
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
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animated_sprite : AnimatedSprite2D
func _ready():
	animated_sprite = get_node("AnimatedSprite2D")
	%ClickableArea.clickable_input_event.connect(_on_clickable_input_event)
	pass
	
func _on_clickable_input_event(event, input_position):
	if event.pressed:
		velocity.y = jump_force

func _physics_process(delta):
	if(GameManager.get_game_enabled()):
	# Apply gravity
		velocity.y += gravity * delta
		if(velocity.y>=-25 and velocity.y<5):
			animated_sprite.play("default")
		elif(velocity.y <-25):
			animated_sprite.play("up")
		else:
			animated_sprite.play("down")
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
		global_position.x = clamp(global_position.x, %ClickableArea.get_play_area_position().x,%ClickableArea.get_play_area_position().x+%ClickableArea.get_play_area_size().x)
		global_position.y = clamp(global_position.y, %ClickableArea.get_play_area_position().y,%ClickableArea.get_play_area_position().y+%ClickableArea.get_play_area_size().y)



	else:
		velocity.y = 0


