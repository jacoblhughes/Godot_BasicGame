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
	target_position = start_position.global_position
	saucer = get_parent().get_node("PerryRun")
	saucer.game_start.connect(_on_game_start)
	saucer.out_of_bounds.connect(_on_out_of_bounds)
	PlayArea.in_play_area.connect(_on_in_play_area)
	pass

func _on_in_play_area(event):
	if(GameManager.get_game_enabled() and game_on == true):
		if event is InputEventScreenTouch:
			if event.pressed:
				is_touching = true
				target_position = event.position
				printerr(event.position)
	pass

func _physics_process(delta):
	print(global_position,position)
	if(GameManager.get_game_enabled() and game_on == true):
		var to_target = target_position - global_position
		var direction = to_target.normalized()
		if(direction.x<0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		var distance_to_target = to_target.length()
		if is_touching:
			if distance_to_target > stop_threshold:
				velocity = direction * move_speed
			else:
				velocity = Vector2.ZERO  # Stop moving if within threshold
				is_touching = false  # Optionally reset touching to require new input to move again

			# Move the character and slide along collisions
			move_and_slide()
		else:
			# Decelerate to a stop when not touching
			velocity = velocity.move_toward(Vector2.ZERO, move_speed * delta)
			move_and_slide()
			
func _on_game_start():
	game_on = true

func _on_out_of_bounds(reset_point):
	target_position=reset_point
