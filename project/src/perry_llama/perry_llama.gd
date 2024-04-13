extends Node2D

@onready var enemy_scenes  = [preload("res://src/perry_llama/enemy.tscn"),preload("res://src/perry_llama/enemy_width.tscn"),preload("res://src/perry_llama/enemy_height.tscn"),preload("res://src/perry_llama/enemy_large.tscn")]
@onready var player : CharacterBody2D
@onready var enemy_spawn_timer : Timer
var score_value = 1

@onready var enemy_spawner : Node2D
@onready var start_position : Marker2D

@onready var despawn : Area2D

var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	start_position = %StartPosition
	enemy_spawn_timer = %EnemySpawnTimer
	player = %Player
	enemy_spawner = %EnemySpawner

#	_game_initialize()
	player.dino_hit.connect(_on_dino_hit)
	despawn = %Despawn
	despawn.body_entered.connect(_on_despawn_body_entered)
	
	
	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280
	print(xform , " " , yform)
	if yform > 1280:
		%Camera2D.enabled = true
		%Camera2D.zoom.y = yform/1280

	if xform > 720:
		var nodes_to_move =[start_position,enemy_spawner,%PerryRun]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()
	
	for node in get_tree().get_nodes_in_group("enemy"):
		node.remove_from_group("enemy")
	pass # Replace with function body.


func _on_enemy_spawn_timer_timeout():
	var enemy_choice = floor(randf_range(0, 4))
	var enemy = enemy_scenes[enemy_choice].instantiate()
	enemy_spawner.add_child.call_deferred(enemy,true)
	pass # Replace with function body.


func _on_despawn_body_entered(body):

	if body is PerryLlamaEnemy:
		body.queue_free()
		HUD.update_score(score_value)
	if HUD.check_advance_level():
		advance_level()
	pass # Replace with function body.
	
func advance_level():
	enemy_spawn_timer.wait_time = enemy_spawn_timer.original_time * pow(.95,HUD.get_game_level())

func _on_play_button_pressed():

	GameManager.set_game_enabled(true)
	enemy_spawn_timer.start()

func _on_dino_hit():
	if GameManager.get_game_enabled():
		HUD.update_lives(-1)
	
func _on_game_over():
	enemy_spawn_timer.stop()
	GameManager.set_game_enabled(false)
	GameStartGameOver.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
	player.global_position = start_position.global_position
	var enemies = get_tree().get_nodes_in_group("enemy")
	for node in enemies:
		queue_free()
