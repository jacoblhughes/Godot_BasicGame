extends RigidBody2D

var force = 500
var target_position = Vector2(0,0)
var lerp_speed = 0.1
var is_touching = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	print(GameManager.get_game_enabled())
	if(GameManager.get_game_enabled()):
		if event is InputEventScreenTouch:
			print('awer')
			if event.pressed:
				is_touching = true
				target_position = event.position
			else:
				is_touching = false

		# Check for touch drag events
		elif event is InputEventScreenDrag and is_touching:
			target_position = event.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

#	var mouse_pos = get_viewport().get_mouse_position()
#	target_y = mouse_pos.y
	position = position.lerp(target_position, lerp_speed)
	position.x = clamp(position.x, GameManager.PlayArea.global_position.x,GameManager.PlayArea.global_position.x+GameManager.PlayArea.size.x)
	position.y = clamp(position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y)
