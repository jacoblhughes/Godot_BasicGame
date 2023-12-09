extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var start_position_marker : Marker2D
signal took_damage
@onready var RocketShootSound : AudioStreamPlayer = $RocketShootSound
@onready var player_hit_sound : AudioStreamPlayer = $PlayerDamageSound
@onready var rocket_timer : Timer
@onready var perry_space : Node2D
signal enemy_hit
# Get the gravity from the project settings to be synced with RigidBody nodes.

var screen_size = GameManager.get_play_area_size_from_HUD()
var screen_position = GameManager.get_play_area_position_from_HUD()


@onready var rocket_scene = preload("res://src/perry_space/rocket.tscn")

var rocketspawn_node
var target_position = Vector2(0,0)
var lerp_speed = 0.1
var is_touching = false 
var original_rocket_time = .9
func _ready():
	perry_space = get_parent().get_node("PerrySpace")
	rocket_timer = $RocketTimer
	rocket_timer.wait_time = original_rocket_time
	rocketspawn_node = get_node("RocketSpawn")
	start_position_marker = get_parent().get_node("StartPosition")
	target_position = start_position_marker.position
	GameManager.in_play_area.connect(_on_in_play_area)
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):


	global_position = global_position.lerp(target_position, lerp_speed)
	global_position.x = clamp(global_position.x, GameManager.PlayArea.global_position.x,GameManager.PlayArea.global_position.x+GameManager.PlayArea.size.x)
	global_position.y = clamp(global_position.y, GameManager.PlayArea.global_position.y,GameManager.PlayArea.global_position.y+GameManager.PlayArea.size.y)


func shoot():
	var rocket_instance = rocket_scene.instantiate()
	rocketspawn_node.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80
	rocket_instance.enemy_hit.connect(_on_enemy_hit)
	RocketShootSound.play()

func _on_enemy_hit():
	enemy_hit.emit()

func take_damage():
	player_hit_sound.play()
	took_damage.emit()


func _on_rocket_timer_timeout():

	shoot()
	pass # Replace with function body.
