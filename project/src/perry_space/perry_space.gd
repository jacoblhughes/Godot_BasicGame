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
#	_game_initialize()
	pass # Replace with function body.
#	enemy_spawn_timer = get_parent().get_node("Enemy_Spawn_Timer")
#	player = get_parent().get_node("Player")


func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	enemy_timer.start()

	rocket_timer.start()

func _on_enemy_deathzone_area_entered(area):

	if area is SpaceEnemy:
		_on_player_hit()
		player.player_hit_sound.play()
		area.queue_free()
	
	pass # Replace with function body.
	
func _on_rocket_deathzone_area_entered(area):

	if area is SpaceRocket:
		area.queue_free()
	
	pass # Replace with function body.

func _on_player_hit():
	HUD.update_lives(-lives_lost)
	
	if(HUD.get_lives()<=0):
		_game_over()

func _game_over():
	HUD.set_gameover_panel(true)
	GameManager.set_game_enabled(false)
	enemy_timer.stop()

	var enemies = get_tree().get_nodes_in_group("enemies")
	for item in enemies:
		item.queue_free()
	rocket_timer.stop()
	GameManager.check_highscore_and_rank()

func _on_enemy_hit():
	HUD.update_score(score_value)
	if HUD.check_advance_level(level_advance_value,level_value):
		advance_level()
	
func advance_level():
	#rocket_timer.wait_time = player.original_rocket_time * pow(.95,GameManager.get_game_level())
	enemy_timer.wait_time = enemy_spawner.original_enemy_time * pow(.95,GameManager.get_game_level())
