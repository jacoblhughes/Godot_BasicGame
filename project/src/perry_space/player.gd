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
	%ClickableArea.clickable_input_event.connect(_on_clickable_input_event)
	pass
	
func _on_clickable_input_event(input_position):
	if(GameManager.get_game_enabled()):
		target_position = input_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

	if target_position !=null:
		global_position = global_position.lerp(target_position, lerp_speed)
	global_position.x = clamp(global_position.x, %ClickableArea.get_play_area_position().x,%ClickableArea.get_play_area_position().x+%ClickableArea.get_play_area_size().x)
	global_position.y = clamp(global_position.y, %ClickableArea.get_play_area_position().y,%ClickableArea.get_play_area_position().y+%ClickableArea.get_play_area_size().y)



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
