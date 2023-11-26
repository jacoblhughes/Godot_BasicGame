extends CharacterBody2D
var reset_round = false

@onready var game = get_parent().get_node("PerryPolo")
# Called when the node enters the scene tree for the first time.
var position_reset = false
var stored_position = Vector2(0,0)
@export var speed_increase = 1.05
@export var original_velocity = Vector2(-100,0)
var collision_cooldown: float = 1.0
const COLLISION_COOLDOWN_DURATION: float = 0.2
var max_speed = 800
@onready var background : TextureRect
func _ready():
	background = get_parent().get_node("Background")
	_game_initialize()

	stored_position = position
	reset_round = true
	pass # Replace with function body.
	
func _game_initialize():
	game.position_reset.connect(_on_position_reset)
	game.in_background.connect(_on_in_background)
	GameManager.resetButtonPressed.connect(_on_reset_button_reset_button_pressed)


func _physics_process(delta):

	if(velocity.length() > max_speed):
		velocity = velocity.normalized() * max_speed
	if(velocity != Vector2(0,0)):
		$AnimatedSprite2D.play("moving")
	else:
		$AnimatedSprite2D.play("default")
	if collision_cooldown > 0:
		collision_cooldown -= delta
	
	if collision_cooldown<=0:
		var collision = move_and_collide(velocity * delta)
		if collision:
			var this_collision = collision.get_collider()
			if "Paddle" in this_collision.name:	
				var reflect_direction = collision.get_remainder().bounce((collision.get_normal()).normalized())
				velocity = velocity.bounce((collision.get_normal()).normalized())*speed_increase
				if(velocity.length() > max_speed):
					velocity = velocity.normalized() * max_speed
				move_and_collide(reflect_direction)

			else:
				var reflect_direction = collision.get_remainder().bounce(collision.get_normal())
				velocity = velocity.bounce(collision.get_normal())
				if(velocity.length() > max_speed):
					velocity = velocity.normalized() * max_speed
				move_and_collide(reflect_direction)

func _on_play_button_pressed():
	if reset_round:
		reset_round = false
	pass
	
func _on_reset_button_reset_button_pressed():
	position_reset = true
	
func _on_position_reset():

	_reset_ball()

func _on_in_background(event):
	
	if(GameManager.get_game_enabled()):
			
			if Input.is_action_pressed("left_mouse_click") and reset_round:
				var swing_angle = randi_range (-45, 45)

	# Rotate the original velocity by the swing angle
				velocity = original_velocity.rotated(deg_to_rad(swing_angle))

	#			velocity = original_velocity
				reset_round = false

func _input(event):
	pass
	

func _reset_ball():
	position_reset = true
	position = stored_position
	velocity = Vector2(0,0)
	position_reset = false
	reset_round = true
