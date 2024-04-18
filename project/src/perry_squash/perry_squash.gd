extends Node3D

@export var mob_scene: PackedScene

var enemies

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3

func _ready():

	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.hide()

	%Player.hit.connect(_on_player_hit)
	%EnemyTimer.timeout.connect(_on_mob_timer_timeout)
#	_game_initialize()
	for node in get_tree().get_nodes_in_group("enemy"):
		node.remove_from_group("enemy")


func _physics_process(delta):
	if GameManager.get_game_enabled():
		%Spotlight.position.x  = %Player.position.x
		%Spotlight.position.z = %Player.position.z

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	var mob_spawn_location = %SpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var player_position = %Player.position
	mob.initialize(mob_spawn_location.position, player_position)
	mob.squashed.connect(_on_mob_squashed)
	add_child(mob)

func _on_player_hit():
	if GameManager.get_game_enabled():
		HUD.update_lives()

func _on_game_over():
	for node in get_tree().get_nodes_in_group("enemy"):
		node.velocity= Vector3.ZERO
	%EnemyTimer.stop()
	%Player.allow_move(false)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	HUD.set_start_timer_countdown_and_start()

func _on_start_timer_countdown_timeout():
	%Player.allow_move(true)
	%EnemyTimer.start()

func _on_mob_squashed():
	HUD.update_score()

