extends Node2D

var score_value = 1
var level_advance_value = 10
var level_value = 1 
var original_spawn_timer = 1
var scenes
@export var enemy_wall : PackedScene
@export var enemy_wall_2 : PackedScene
@export var enemy_wall_3 : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	scenes = [enemy_wall, enemy_wall_2, enemy_wall_3]
	print("-----------------------------")
	print(get_viewport_rect())
	print(get_viewport_transform().get_scale())
	var xwindow = get_window().get_size().x
	var ywindow = get_window().get_size().y
	print(xwindow," & ", ywindow)
#	if ywindow >:
		
#	var xform = float(720.0/get_window().get_size().x)
#	var yform = float(1280.0/get_window().get_size().y)
#	%Camera2D.zoom = Vector2(yform,xform)
	print(float(720.0/get_window().get_size().x))
	print(float(1280.0/get_window().get_size().y))
#	print(float(720.0/get_window().get_size().x))
#	print(float(1280.0/get_window().get_size().y))
	_game_initialize()
	%Player.flappy_hit.connect(_on_flappy_hit)
	%EnemySpawnPosition.global_position.x = xwindow
	%SpawnTimer.wait_time = original_spawn_timer
	pass # Replace with function body.

func _game_initialize():
	HUD.reset_score()
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_level(1)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	%Player.position = %StartPosition.position
	%SpawnTimer.start()
	pass


func _on_enemy_scoring_body_entered(body):

	HUD.update_score(score_value)
	if HUD.check_advance_level(level_advance_value,level_value):
		advance_level()
	pass # Replace with function body.

func _on_flappy_hit():
	if(GameManager.get_game_enabled()):
		_game_over()
		
func _game_over():
	for nodes in get_tree().get_nodes_in_group("enemy"):
		nodes.remove_from_group("enemy")
		nodes.queue_free()
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)
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
	if body is PlayerFlappy:
		if(GameManager.get_game_enabled()):
			_game_over()
	pass # Replace with function body.
