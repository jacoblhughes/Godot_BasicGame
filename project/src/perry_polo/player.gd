extends Paddle

@onready var game = get_parent().get_node("PerryPolo")
@onready var my_sprite : Sprite2D
@onready var collision_object : CollisionPolygon2D
@onready var ball : CharacterBody2D
var sizeOfPaddle: Vector2
@export var starting_position_marker : Marker2D
var target_y
var lerp_speed = 0.1
var is_touching = false  # To keep track of whether the screen is currently being touched
var sprite_half_y
var initial_touch_y
@onready var background : TextureRect
# Called when the node enters the scene tree for the first time.
func _ready():
	target_y = starting_position_marker.global_position.y
	background = get_parent().get_node("Background")
	my_sprite = $Sprite2D
	collision_object=$CollisionPolygon2D
	ball = get_parent().get_node("Ball")
	sizeOfPaddle = my_sprite.get_rect().size
	sprite_half_y= sizeOfPaddle.y/4
	PlayArea.in_play_area.connect(_on_in_play_area)
	pass # Replace with function body.
	
func _on_in_play_area(event):

	if GameManager.get_game_enabled():
		# Check for touch events
		if event is InputEventScreenTouch:
			if event.pressed:
				is_touching = true
				initial_touch_y = event.position.y
				target_y = initial_touch_y
			else:
				is_touching = false

		# Check for touch drag events
		elif event is InputEventScreenDrag:
			initial_touch_y = event.position.y
			# Update target_y based on the difference in Y coordinates
			target_y = initial_touch_y + event.relative.y

func _physics_process(_delta):
#	var mouse_pos = get_viewport().get_mouse_position()
#	target_y = mouse_pos.y
	global_position.y = lerp(global_position.y, target_y, lerp_speed)
	global_position.y = clamp(global_position.y, PlayArea.get_play_area_position().y + sprite_half_y,PlayArea.get_play_area_position().y+ PlayArea.get_play_area_size().y - sprite_half_y)
