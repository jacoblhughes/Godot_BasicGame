extends CharacterBody2D
class_name PerrySquashPlayer

const SPEED = 200.0
var is_slamming = false
var normal = true
var direction
@export var start_marker: Marker2D
var start_position
@export var end_marker: Marker2D
var end_position
var initialized = false

func _ready():
	call_deferred("initialize_positions")

func initialize_positions():
	start_position = start_marker.position
	end_position = end_marker.position
	initialized = true

func _physics_process(delta):
	if initialized:
		if normal:
			direction = 1
		if !normal:
			direction = -1
		if normal and position.x >= end_position.x:
			normal = false
		if !normal and position.x <= start_position.x:
			normal = true
		if !is_slamming and int(position.y) == start_position.y:
			velocity.x = direction * SPEED
		if is_on_floor():
			is_slamming = false
		if !is_slamming and position.y > start_position.y:
			position = position.lerp(Vector2(position.x,start_position.y),.1)
		else:
			direction = 0
			velocity.y = 1500
		if Input.is_action_pressed("ui_accept"):
			is_slamming = true
			velocity = Vector2.ZERO
		move_and_slide()

func take_damage():
	HUD.update_lives()
