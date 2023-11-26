extends CharacterBody2D
@onready var game = get_parent().get_node("PerryPolo")
@onready var my_sprite : Sprite2D
@onready var collision_object : CollisionShape2D
@onready var ball : CharacterBody2D
@export var sizeOfPaddle: Vector2
var target_y = GameManager.PlayArea.size.y/2
var lerp_speed = 0.1
var is_touching = false  # To keep track of whether the screen is currently being touched
var sprite_half_y
@onready var background : TextureRect
# Called when the node enters the scene tree for the first time.
func _ready():
	background = get_parent().get_node("Background")
	my_sprite = $Sprite2D
	collision_object=$CollisionShape2D
	ball = get_parent().get_node("Ball")
	sizeOfPaddle = my_sprite.get_rect().size
	sprite_half_y= sizeOfPaddle.y/2
	game.in_background.connect(_on_in_background)
	pass # Replace with function body.
	
func _on_in_background(event):
	print('hererer')
	print(event)
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

func _input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
#	var mouse_pos = get_viewport().get_mouse_position()
#	target_y = mouse_pos.y
	global_position.y = lerp(global_position.y, target_y, lerp_speed)
	global_position.y = clamp(global_position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y - sprite_half_y)
