extends Area2D
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size
# Called when the node enters the scene tree for the first time.
var velocity = Vector2.ZERO # The player's movement vector.

func _ready():
	screen_size = get_parent().get_node("Play_Area").size
	pass # Replace with function body.


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
		$Animation.play()
	else:
		$Animation.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	pass
