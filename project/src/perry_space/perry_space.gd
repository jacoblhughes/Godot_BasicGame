extends Node2D

@onready var enemy_timer : Timer


@onready var player : CharacterBody2D
@onready var rocket_timer : Timer

signal game_start

var enemy_spawner

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

#	if yform > 1280:
#		%Camera2D.enabled = true
#		%Camera2D.zoom.y = yform/1280

	if xform > 720:
		var nodes_to_move =[%EnemyDeathzone,%RocketDeathzone,%Marker1,%Marker2,%Marker3,%Marker4,%Marker5]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.position.x *= xatio
	
	enemy_spawner = %EnemySpawner
	enemy_timer = %EnemyTimer

	rocket_timer = %RocketTimer
	player = %Player
	player.took_damage.connect(_on_player_hit)
	player.enemy_hit.connect(_on_enemy_hit)
	%EnemyDeathzone.area_entered.connect(_on_enemy_deathzone_area_entered)
	%RocketDeathzone.area_entered.connect(_on_rocket_deathzone_area_entered)
	
	pass # Replace with function body.



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
	HUD.update_lives()

func _on_game_over():
	enemy_timer.stop()

	var enemies = get_tree().get_nodes_in_group("enemies")
	for item in enemies:
		item.queue_free()
	rocket_timer.stop()
	GameManager.check_highscore_and_rank()

func _on_enemy_hit():
	HUD.update_score()
	if HUD.check_advance_level():
		advance_level()
	
func advance_level():

	enemy_timer.wait_time = enemy_spawner.original_enemy_time * pow(.95,HUD.return_game_level())
