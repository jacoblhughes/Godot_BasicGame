extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal took_damage
@onready var RocketShootSound : AudioStreamPlayer = $RocketShootSound
# Get the gravity from the project settings to be synced with RigidBody nodes.

var screen_size = GameManager.get_play_area_size_from_HUD()
var screen_position = GameManager.get_play_area_position_from_HUD()

@onready var rocket_scene = preload("res://scenes/Attack/rocket.tscn")

var rocketspawn_node

func _ready():
	rocketspawn_node = get_node("RocketSpawn")
	pass

func start(new_position):
	position = new_position

func _process(delta):
	if Input.is_action_just_pressed("hit_space"):
		shoot()

func _physics_process(delta):
	
	velocity=Vector2(0,0)
	# Add the gravity.
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("move_up"):
		velocity.y = -SPEED
	if Input.is_action_pressed("move_down"):
		velocity.y = SPEED
	move_and_slide()
	position = position.clamp(screen_position, screen_position+screen_size)	

func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocketspawn_node.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	RocketShootSound.play()
	
func take_damage():
	took_damage.emit()
	
