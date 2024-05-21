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

var base_enemy_timer_time = 1
var base_enemy_spawn_probability = .1

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	var advance_level_callable = Callable(self,"_on_advance_level")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value,advance_level_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()

	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280

	if yform > 1280:
		var nodes_to_move = [%Player,%StartPosition,%EndPosition,%Floor,%EnemySpawnRight,%EnemySpawnLeft,%EnemyDespawnLeft,%EnemyDespawnRight]
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = [%Floor]
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var nodes_to_move = [%Player,%StartPosition,%EndPosition,%Floor,%EnemySpawnRight,%EnemySpawnLeft,%EnemyDespawnLeft,%EnemyDespawnRight]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = [%Floor]
		for node in nodes_to_scale:
			node.scale.x *= xatio

	%EnemySpawn.enemy_squashed.connect(_on_enemy_squashed)
	%EnemySpawn.probability = base_enemy_spawn_probability
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func _on_enemy_squashed():
	HUD.update_score()


func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_game_over():
	GameManager.set_game_enabled(false)

func _on_advance_level():
	%EnemyTimer.wait_time = base_enemy_timer_time * pow(.95,HUD.return_game_level())
	%EnemySpawn.probability = base_enemy_spawn_probability * pow(1.05,HUD.return_game_level())
