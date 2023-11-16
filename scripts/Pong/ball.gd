extends CharacterBody2D
var reset_round = false

@onready var PONGSIGNALS = get_parent().get_node("pong")
# Called when the node enters the scene tree for the first time.
var position_reset = false
var stored_position = Vector2(0,0)
@export var speed_increase = 1.05
@export var original_velocity = Vector2(-150,50)
var collision_cooldown: float = 1.0
const COLLISION_COOLDOWN_DURATION: float = 0.2
var max_speed = 800

func _ready():

	_game_initialize()

	stored_position = position
	reset_round = true
	pass # Replace with function body.
	
func _game_initialize():
	PONGSIGNALS.position_reset.connect(_on_position_reset)

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
				print(third," normal: ",normal_direction)
				var bounce_direction

				if(third == 1):
					if (normal_direction >0):
						bounce_direction = Vector2(1, -1).normalized()
					else:
						bounce_direction = Vector2(-1, -1).normalized()
					# Reflect the velocity along the new direction
					var reflect_direction = collision.get_remainder().bounce((collision.get_normal()*bounce_direction).normalized())
					velocity = velocity.bounce((collision.get_normal()*bounce_direction).normalized())*speed_increase
					if(velocity.length() > max_speed):
						velocity = velocity.normalized() * max_speed
					move_and_collide(reflect_direction)

				elif(third == 2):
					var reflect_direction = collision.get_remainder().bounce(collision.get_normal())
					velocity = velocity.bounce(collision.get_normal())*speed_increase
					if(velocity.length() > max_speed):
						velocity = velocity.normalized() * max_speed
					move_and_collide(reflect_direction)
				else:
					if (normal_direction >0):
						bounce_direction = Vector2(1, 1).normalized()
					else:
						bounce_direction = Vector2(-1, 1).normalized()
					var reflect_direction = collision.get_remainder().bounce((collision.get_normal()*bounce_direction).normalized())
					velocity = velocity.bounce((collision.get_normal()*bounce_direction).normalized())*speed_increase
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

func _input(_event):

	if(GameManager.get_game_enabled()):
		
		if Input.is_action_pressed("left_mouse_click") and reset_round:

			velocity = original_velocity
			reset_round = false

func _reset_ball():
	position_reset = true
	position = stored_position
	velocity = Vector2(0,0)
	position_reset = false
	reset_round = true
