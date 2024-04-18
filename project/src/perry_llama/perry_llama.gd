extends Node2D

@export var enemy_scenes : Array[PackedScene] = []
@onready var enemy_spawn_timer : Timer

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3


# Called when the node enters the scene tree for the first time.
func _ready():

	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()

	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280
	print(xform , " " , yform)

	if yform > 1280:
		var nodes_to_move = [%StartPosition,%EnemySpawner,%PerryRun,%Floor,%Despawn]
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var nodes_to_move = [%StartPosition,%EnemySpawner,%PerryRun]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []

	enemy_spawn_timer = %EnemySpawnTimer
	%Player.dino_hit.connect(_on_dino_hit)
	%Despawn.body_entered.connect(_on_despawn_body_entered)

	for node in get_tree().get_nodes_in_group("enemy"):
		node.remove_from_group("enemy")

	pass # Replace with function body.


func _on_enemy_spawn_timer_timeout():
	var enemy_choice = floor(randf_range(0, 4))
	var enemy = enemy_scenes[enemy_choice].instantiate()
	%EnemySpawner.add_child.call_deferred(enemy,true)
	pass # Replace with function body.


func _on_despawn_body_entered(body):

	if body is PerryLlamaEnemy:
		body.queue_free()
		HUD.update_score()
	if HUD.check_advance_level():
		advance_level()
	pass # Replace with function body.

func advance_level():
	enemy_spawn_timer.wait_time = enemy_spawn_timer.original_time * pow(.95,HUD.return_game_level())

func _on_play_button_pressed():

	GameManager.set_game_enabled(true)
	enemy_spawn_timer.start()

func _on_dino_hit():
	if GameManager.get_game_enabled():
		HUD.update_lives()

func _on_game_over():
	enemy_spawn_timer.stop()
	%Player.global_position = %StartPosition.global_position
	var enemies = get_tree().get_nodes_in_group("enemy")
	for node in enemies:
		queue_free()
