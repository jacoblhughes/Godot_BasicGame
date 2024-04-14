extends CharacterBody2D



var double_jump_counter = false
const JUMP_VELOCITY = -600.0
var rng = RandomNumberGenerator.new()
var animation_player: AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
signal dino_hit
func _ready():
	animation_player = $AnimatedSprite2D
	HUD.clickable_input_event.connect(_on_clickable_input_event)
#func _input(event):
#		if event.is_action_pressed("left_mouse_click"):
#			velocity.y = JUMP_VELOCITY

func _on_clickable_input_event(event, input_position):
	if event.pressed:
		if(GameManager.get_game_enabled()):
			if is_on_floor():
				velocity.y = JUMP_VELOCITY
			elif not is_on_floor() and double_jump_counter  == false:
				velocity.y = JUMP_VELOCITY
				double_jump_counter = true
	pass

func _physics_process(delta):
	if not is_on_floor():
		animation_player.play("jumping")
		velocity.y += gravity * delta
		
	if is_on_floor():
		animation_player.play("default")  # Start the "jumping" animation
		double_jump_counter = false

	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)

		if("Enemy" in collision.get_collider().name):

			collision.get_collider().queue_free()

			dino_hit.emit()
