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
	target_position = start_position.position
	start(target_position) 
#	hide()

func _input(event):
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

#	var mouse_pos = get_viewport().get_mouse_position()
#	target_y = mouse_pos.y
	position = position.lerp(target_position, lerp_speed)
	position.x = clamp(position.x, GameManager.PlayArea.global_position.x,GameManager.PlayArea.global_position.x+GameManager.PlayArea.size.x)
	position.y = clamp(position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var velocity = Vector2.ZERO # The player's movement vector.
#	if Input.is_action_pressed("move_right"):
#		velocity.x += 1
#	if Input.is_action_pressed("move_left"):
#		velocity.x -= 1
#	if Input.is_action_pressed("move_down"):
#		velocity.y += 1
#	if Input.is_action_pressed("move_up"):
#		velocity.y -= 1
#
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
#		$AnimatedSprite2D.play()
#	else:
#		$AnimatedSprite2D.stop()
#
#	position += velocity * delta
#	position = position.clamp(screen_position, screen_position+screen_size)	
#	if velocity.x != 0:
#		$AnimatedSprite2D.animation = "walking"
#		$AnimatedSprite2D.flip_v = false
#		# See the note below about boolean assignment.
#		$AnimatedSprite2D.flip_h = velocity.x < 0
#	elif velocity.y != 0:
#		$AnimatedSprite2D.animation = "up"
#		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body):

	hit.emit()
	print('hit')
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	$CollisionShape2D.set_deferred("disabled", false)


