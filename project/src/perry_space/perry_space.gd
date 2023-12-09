extends Node2D

@onready var enemy_timer : Timer


@onready var player : CharacterBody2D
@onready var rocket_timer : Timer
var lives_lost=1
signal game_start
var level_advance_value = 10
var level_value = 1
var score_value = 1
var enemy_spawner
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_spawner = get_parent().get_node("EnemySpawner")
	enemy_timer = get_parent().get_node("EnemySpawner/EnemyTimer")

	rocket_timer = get_parent().get_node("Player/RocketTimer")
	player = get_parent().get_node("Player")
	player.took_damage.connect(_on_player_hit)
	player.enemy_hit.connect(_on_enemy_hit)
	_game_initialize()
	pass # Replace with function body.
#	enemy_spawn_timer = get_parent().get_node("Enemy_Spawn_Timer")
#	player = get_parent().get_node("Player")

func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)
	GameManager.set_or_reset_lives(3)
	GameManager.set_or_reset_level(1)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	enemy_timer.start()

	rocket_timer.start()

func _on_deathzone_area_entered(area):
	_on_player_hit()
	area.queue_free()
	
	pass # Replace with function body.

func _on_player_hit():
	GameManager.update_lives(-lives_lost)
	
	if(GameManager.get_lives()<=0):
		_game_over()

func _game_over():
	GameManager.set_gameover_panel(true)
	GameManager.set_game_enabled(false)
	enemy_timer.stop()

	var enemies = get_tree().get_nodes_in_group("enemies")
	for item in enemies:
		item.queue_free()
	rocket_timer.stop()
	GameManager.check_highscore_and_rank()

func _on_enemy_hit():
	GameManager.update_score(score_value)
	_check_advance_level()
	
func _check_advance_level():
	if(GameManager.get_score() % level_advance_value == 0):
		GameManager.update_game_level(level_value)
#		rocket_timer.wait_time = player.original_rocket_time * pow(.95,GameManager.get_game_level())
		enemy_timer.wait_time = enemy_spawner.original_enemy_time * pow(.95,GameManager.get_game_level())
