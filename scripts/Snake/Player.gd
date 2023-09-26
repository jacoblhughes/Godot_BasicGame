extends Area2D
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size
# Called when the node enters the scene tree for the first time.
var velocity = Vector2.ZERO # The player's movement vector.

var tile_size = 0
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func _ready():
	screen_size = get_parent().get_node("Node2D").get_node("Play_Area").size
	tile_size = screen_size.x/64
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	if Input.is_action_pressed("move_right"):
		velocity.y = 0
		velocity.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.y = 0
		velocity.x = -1
	if Input.is_action_pressed("move_down"):
		velocity.x = 0
		velocity.y = 1
	if Input.is_action_pressed("move_up"):
		velocity.x = 0
		velocity.y = -1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	else:
		pass
	
	position += velocity * (tile_size/128)
	position = position.clamp(Vector2.ZERO, screen_size)
	pass

func _input(event):
	pass
