extends Node2D

@export var mob_scene: PackedScene
var score_value = 1

@onready var ScoreTimer : Timer
@onready var MobTimer : Timer
@onready var StartTimer : Timer
@onready var StartPosition: Marker2D
@onready var Player : Area2D
var original_mob_time = 1
var level_advance_value = 10
var level_value = 1
# Called when the node enters the scene tree for the first time.
func _ready():

	StartTimer = get_parent().get_node("StartTimer")
	ScoreTimer = get_parent().get_node("ScoreTimer")
	MobTimer = get_parent().get_node("MobTimer")
	MobTimer.wait_time = original_mob_time
	StartPosition = get_parent().get_node("StartPosition")
	Player = get_parent().get_node("Player")
	Player.hit.connect(_on_player_hit)
	
	_game_initialize()
	
func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)	


func _on_score_timer_timeout():
	GameManager.update_score(score_value)
	_check_advance_level()
	pass # Replace with function body.
	
func _check_advance_level():
	if(GameManager.get_score() % level_advance_value == 0):
		GameManager.update_game_level(level_value)
		MobTimer.wait_time = original_mob_time * pow(.95,GameManager.get_game_level())

func _on_start_timer_timeout():
	MobTimer.start()
	ScoreTimer.start()
	StartTimer.stop()

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_parent().get_node("MobPath/MobPathFollow")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var sprite = mob.get_node("AnimatedSprite2D")
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	sprite.rotation = velocity.angle() + PI/2
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	get_parent().add_child(mob)

func _on_player_hit():
	GameManager.set_game_enabled(false)
	GameManager.set_gameover_panel(true)
	MobTimer.stop()
	ScoreTimer.stop()
	GameManager.check_highscore_and_rank()
	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	StartTimer.start()
	pass
