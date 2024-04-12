extends Node2D

@onready var enemy_scenes  = [preload("res://src/perry_llama/enemy.tscn"),preload("res://src/perry_llama/enemy_width.tscn"),preload("res://src/perry_llama/enemy_height.tscn"),preload("res://src/perry_llama/enemy_large.tscn")]
@onready var player : CharacterBody2D
@onready var enemy_spawn_timer : Timer
var score_value = 1
var level_advance_value = 10
var level_value = 1
@onready var enemy_spawner : Node2D
@onready var start_position : Vector2
@onready var enemy_position : Vector2
@onready var despawn : Area2D




# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	start_position = %StartPosition.global_position
	enemy_spawn_timer = %EnemySpawnTimer
	player = %Player
	enemy_spawner = %EnemySpawner
	enemy_position = %EnemySpawner.global_position
#	_game_initialize()
	player.dino_hit.connect(_on_dino_hit)
	despawn = %Despawn
	despawn.body_entered.connect(_on_despawn_body_entered)
	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	if yform > 1280:
		%Camera2D.enabled = true
		%Camera2D.zoom.y = yform/1280

#	if xform > 720:
#		var xatio = xform/720
#		%Lose.position.x *= xatio
#		%Win.position.x *= xatio
#		%Lose.scale *= xatio
#		%Win.scale *= xatio
#		%WallTop.position.x *= xatio
#		%WallBottom.position.x *= xatio
#		%WallTop.scale.x *= xatio
#		%WallBottom.scale.x *= xatio
#		print(%Enemy.position)
#		%Enemy.set_x_position(%Enemy.position.x * xatio)
#		print(%Enemy.position)
#		%Ball.position.x *= xatio
#		%PlayerStart.position.x *= xatio
#		%Player.position.x *= xatio
		
	
	
	for node in get_tree().get_nodes_in_group("enemy"):
		node.remove_from_group("enemy")
	pass # Replace with function body.


func _on_enemy_spawn_timer_timeout():
	var enemy_choice = floor(randf_range(0, 4))
	var enemy = enemy_scenes[enemy_choice].instantiate()
	enemy_spawner.add_child.call_deferred(enemy,true)
	pass # Replace with function body.


func _on_despawn_body_entered(body):

	if("Enemy" in body.name):
		body.queue_free()
		HUD.update_score(score_value)
	if HUD.check_advance_level():
		advance_level()
	pass # Replace with function body.
	
func advance_level():
	enemy_spawn_timer.wait_time = enemy_spawn_timer.original_time * pow(.95,GameManager.get_game_level())

func _on_play_button_pressed():

	GameManager.set_game_enabled(true)
	enemy_spawn_timer.start()

func _on_dino_hit():
	enemy_spawn_timer.stop()
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
	player.global_position = start_position
	var enemies = get_tree().get_nodes_in_group("enemy")
	for node in enemies:
		queue_free()
