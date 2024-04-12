extends Node3D

@export var mob_scene: PackedScene

var enemies
var score_value = 1

var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable

func _ready():
	Background.visible = false
	%Player.hit.connect(_on_player_hit)
	%EnemyTimer.timeout.connect(_on_mob_timer_timeout)
#	_game_initialize()
	for node in get_tree().get_nodes_in_group("enemy"):
		node.remove_from_group("enemy")

	pass
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)



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
		HUD.update_lives(-1)

func _on_game_over():
	for node in get_tree().get_nodes_in_group("enemy"):
		node.velocity= Vector3.ZERO
	%EnemyTimer.stop()
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
	%Player.allow_move(false)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	HUD.countdown_timer_start_and_time_left()

func _on_countdown_timer_timeout():
	%Player.allow_move(true)
	%EnemyTimer.start()

func _on_mob_squashed():
	HUD.update_score(score_value)

