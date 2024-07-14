extends Node2D

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3

var base_spawn_timer_time = 2
@export var scenes : Array[PackedScene]
#120	520		30	130
#120	640		30	160
#120	400		30	100
@export var debug : bool

func _ready():

	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	var advance_level_callable = Callable(self,"_on_advance_level")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value,advance_level_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)


	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280

	if yform > 1280:
		var nodes_to_move = [%Player,%EnemyDespawn,%EnemySpawn]
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = [%EnemyDespawn,%EnemySpawn]
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var nodes_to_move =[%EnemySpawn]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.x *= xatio

	if get_node_or_null("ParallaxBackground")!=null:
		if xatio <= 1:
			xatio = 1
		if yatio <= 1:
			yatio = 1
		var parallax_background = get_node_or_null("ParallaxBackground")
		parallax_background.get_resize_dimensions(xatio,yatio)

	%EnemyScoring.area_entered.connect(_on_enemy_scoring_area_entered)
	%SpawnTimer.wait_time = base_spawn_timer_time
	%Player.position = %StartPosition.position
	pass # Replace with function body.


func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	%SpawnTimer.start()

	pass


func _on_enemy_scoring_area_entered(area):
	HUD.update_score()
	pass # Replace with function body.

func _on_game_over():
	for nodes in get_tree().get_nodes_in_group("enemy"):
		nodes.remove_from_group("enemy")
		nodes.queue_free()
	%SpawnTimer.stop()
	%Player.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	%Player.position = %StartPosition.position

func _on_advance_level():
	%SpawnTimer.wait_time = base_spawn_timer_time * pow(.95,HUD.return_game_level())

func _on_spawn_timer_timeout():
	if !debug:
		var chosen_index = randi() % scenes.size()
		var chosen_scene = scenes[chosen_index].instantiate()
		chosen_scene.position = %EnemySpawnPosition.position
		%EnemySpawn.add_child(chosen_scene,true)
		chosen_scene.add_to_group("enemy")
	pass # Replace with function body.

func _on_fly_zone_body_exited(body):
	if body is PerryFlapPlayer:
		if(GameManager.get_game_enabled()):
			%Player.hit()
	pass # Replace with function body.


#extends BaseGame
