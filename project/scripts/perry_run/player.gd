extends CharacterBody2D

var force = 500
var target_position = Vector2(0,0)
var lerp_speed = 0.1
var is_touching = false 
var start_position : Marker2D
var move_speed = 200
var stop_threshold = 10  # Stop moving when within 10 pixels of the target
@onready var saucer : Node2D
var game_on = false
# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = get_parent().get_node("StartPosition")
	target_position = start_position.position
	saucer = get_parent().get_node("PerryRun")
	saucer.game_start.connect(_on_game_start)
	saucer.out_of_bounds.connect(_on_out_of_bounds)
	GameManager.in_play_area.connect(_on_in_play_area)
	pass


			
func _input(event):
	pass

func _on_in_play_area(event):
	if(GameManager.get_game_enabled() and game_on == true):
		if event is InputEventScreenTouch:
			if event.pressed:
				is_touching = true
				target_position = event.position
	pass

func _physics_process(delta):

	if(GameManager.get_game_enabled() and game_on == true):
		var to_target = target_position - global_position
		var direction = to_target.normalized()

		if(abs(direction.x)>abs(direction.y)):
			if(direction.x<0):
				$AnimatedSprite2D.flip_h = true
		else:
				$AnimatedSprite2D.flip_h = false
		var distance_to_target = to_target.length()
		if is_touching:
			# Calculate the direction to the target position
#			var direction = (target_position - position).normalized()
#
#			# Calculate the velocity
#			velocity = direction * move_speed
			if distance_to_target > stop_threshold:
				velocity = to_target.normalized() * move_speed
			else:
				velocity = Vector2.ZERO  # Stop moving if within threshold
				is_touching = false  # Optionally reset touching to require new input to move again

			# Move the character and slide along collisions
			move_and_slide()
		else:
			# Decelerate to a stop when not touching
			velocity = velocity.move_toward(Vector2.ZERO, move_speed * delta)
			move_and_slide()

##	var mouse_pos = get_viewport().get_mouse_position()
##	target_y = mouse_pos.y
#	position = position.lerp(target_position, lerp_speed)
#	position.x = clamp(position.x, GameManager.PlayArea.global_position.x,GameManager.PlayArea.global_position.x+GameManager.PlayArea.size.x)
#	position.y = clamp(position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y)

func _on_game_start():
	game_on = true

func _on_out_of_bounds(reset_point):
	target_position=reset_point
