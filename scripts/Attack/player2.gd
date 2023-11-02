extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var start_position_marker : Marker2D
signal took_damage
@onready var RocketShootSound : AudioStreamPlayer = $RocketShootSound
@onready var rocket_timer : Timer

# Get the gravity from the project settings to be synced with RigidBody nodes.

var screen_size = GameManager.get_play_area_size_from_HUD()
var screen_position = GameManager.get_play_area_position_from_HUD()


@onready var rocket_scene = preload("res://scenes/Attack/rocket.tscn")

var rocketspawn_node
var target_position = Vector2(0,0)
var lerp_speed = 0.1
var is_touching = false 

func _ready():
	rocket_timer = $RocketTimer
	rocketspawn_node = get_node("RocketSpawn")
	start_position_marker = get_parent().get_node("StartPosition")
	target_position = start_position_marker.position
	
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("hit_space"):
		shoot()

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


func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocketspawn_node.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	RocketShootSound.play()
	
func take_damage():
	took_damage.emit()


func _on_rocket_timer_timeout():

	shoot()
	pass # Replace with function body.
