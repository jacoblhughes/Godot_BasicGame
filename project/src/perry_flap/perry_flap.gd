extends Node2D

var score_value = 1
@onready var SpawnTimer : Timer = get_parent().get_node("SpawnTimer")
@onready var player : CharacterBody2D
@onready var start_position_marker : Marker2D
@onready var start_position = Vector2(0,0)
var level_advance_value = 10
var level_value = 1 
@onready var spawn_timer : Timer
var original_spawn_timer = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	_game_initialize()
	player.flappy_hit.connect(_on_flappy_hit)
	start_position_marker = get_parent().get_node('StartPosition')
	start_position = start_position_marker.position
	player.position = start_position
	spawn_timer = get_parent().get_node('SpawnTimer')
	spawn_timer.wait_time = original_spawn_timer
	pass # Replace with function body.

func _game_initialize():
	HUD.reset_score()
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_level(1)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	player.position = start_position
	SpawnTimer.start()
	pass


func _on_enemy_scoring_body_entered(body):

	GameManager.update_score(score_value)
	_check_advance_level()
	pass # Replace with function body.

func _on_flappy_hit():
	if(GameManager.get_game_enabled()):
		_game_over()
		
func _game_over():
	for nodes in get_tree().get_nodes_in_group("enemy"):
		nodes.remove_from_group("enemy")
		nodes.queue_free()
	GameManager.set_game_enabled(false)
	GameManager.set_gameover_panel(true)
	SpawnTimer.stop()
	player.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	player.position = start_position
	GameManager.check_highscore_and_rank()

func _on_area_2d_body_exited(body):
	if body is PlayerFlappy:
		if(GameManager.get_game_enabled()):
			_game_over()
	pass # Replace with function body.

func _check_advance_level():
	if(GameManager.get_score() % level_advance_value == 0):
		GameManager.update_game_level(level_value)
		spawn_timer.wait_time = original_spawn_timer * pow(.95,GameManager.get_game_level())
