extends Area2D
signal hit

var player_collision = true
@onready var CollisionShape : CollisionShape2D
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var screen_position
@onready var start_position : Marker2D

var target_position
var lerp_speed = 0.1
var is_touching = false 

# Called when the node enters the scene tree for the first time.
func _ready():

#	CollisionShape = $CollisionShape2D
	screen_size = GameManager.get_play_area_size_from_HUD()
	screen_position = GameManager.get_play_area_position_from_HUD()
	start_position = get_parent().get_node('StartPosition')
	target_position = start_position.global_position
	GameManager.in_play_area.connect(_on_in_play_area)
	start(target_position) 
#	hide()

func _input(event):
	pass
	
func _on_in_play_area(event):
	if(GameManager.get_game_enabled()):
	# Check for touch events

		if event is InputEventScreenTouch:
			if event.pressed:
				is_touching = true
				target_position = event.position
			else:
				is_touching = false

		# Check for touch drag events
		elif event is InputEventScreenDrag and is_touching:
			target_position = event.position

		var to_target = target_position - global_position
		var direction = to_target.normalized()

		if(abs(direction.x)>abs(direction.y)):
			$AnimatedSprite2D.play("walking")
			if(direction.x>0):
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.play("up")
			if(direction.y>0):
				$AnimatedSprite2D.flip_v = true
			else:
				$AnimatedSprite2D.flip_v = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

#	var mouse_pos = get_viewport().get_mouse_position()
#	target_y = mouse_pos.y
	global_position = global_position.lerp(target_position, lerp_speed)
	global_position.x = clamp(global_position.x, GameManager.PlayArea.global_position.x,GameManager.PlayArea.global_position.x+GameManager.PlayArea.size.x)
	global_position.y = clamp(global_position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y)



func _on_body_entered(body):

	hit.emit()

	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	$CollisionShape2D.set_deferred("disabled", false)


