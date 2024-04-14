extends Node2D

var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable

var score_advance_value = 1

var original_spawn_timer = 1.5

@export var enemy_wall : PackedScene
@export var enemy_wall_2 : PackedScene
@export var enemy_wall_3 : PackedScene
var scenes : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	scenes = [enemy_wall, enemy_wall_2, enemy_wall_3]
	
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")	
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()
	
	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280

	if yform > 1280:
		%Camera2D.enabled = true
#		%Camera2D.zoom.y = yform/1280

	if xform > 720:

		var nodes_to_move =[%EnemySpawnPosition]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = [%Map]
		for node in nodes_to_scale:
			node.scale.x *= xatio
	

	%SpawnTimer.wait_time = original_spawn_timer
	%Player.position = %StartPosition.position
	pass # Replace with function body.


func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	%SpawnTimer.start()
	pass


func _on_enemy_scoring_body_entered(body):

	HUD.update_score(score_advance_value)
	if HUD.check_advance_level():
		advance_level()
	pass # Replace with function body.
		
func _on_game_over():

	for nodes in get_tree().get_nodes_in_group("enemy"):
		nodes.remove_from_group("enemy")
		nodes.queue_free()
	GameManager.set_game_enabled(false)
	GameStartGameOver.set_gameover_panel(true)
	%SpawnTimer.stop()
	%Player.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	%Player.position = %StartPosition.position
	GameManager.check_highscore_and_rank()


func advance_level():
	%SpawnTimer.wait_time = original_spawn_timer * pow(.95,HUD.get_game_level())

func _on_spawn_timer_timeout():
	var chosen_index = randi() % scenes.size()
	var chosen_scene = scenes[chosen_index].instantiate()
	chosen_scene.position = %EnemySpawnPosition.position
	add_child(chosen_scene,true)

	chosen_scene.add_to_group("enemy")
	pass # Replace with function body.

func _on_fly_zone_body_exited(body):
	if body is PerryFlapPlayer:
		if(GameManager.get_game_enabled()):
			%Player.hit()
	pass # Replace with function body.
