extends CharacterBody2D

@onready var my_sprite : ColorRect
@onready var collision_object : CollisionShape2D
@onready var ball : CharacterBody2D
@export var sizeOfPaddle: Vector2
var target_y = 0.0
var lerp_speed = 0.1
var is_touching = false  # To keep track of whether the screen is currently being touched
# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $ColorRect
	collision_object=$CollisionShape2D
	ball = get_parent().get_node("Ball")
	sizeOfPaddle = my_sprite.size

	pass # Replace with function body.
func _input(event):
	if(GameManager.get_game_enabled()):
	# Check for touch events
		if event is InputEventScreenTouch:
			if event.pressed:
				is_touching = true
				target_y = event.position.y
			else:
				is_touching = false

		# Check for touch drag events
		elif event is InputEventScreenDrag and is_touching:
			target_y = event.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
#	var mouse_pos = get_viewport().get_mouse_position()
#	target_y = mouse_pos.y
	position.y = lerp(position.y, target_y, lerp_speed)
	position.y = clamp(position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y - my_sprite.size.y)
