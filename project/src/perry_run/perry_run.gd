extends Node2D

@export var player_scene : PackedScene

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 60


var reset_point
var game_on = false
var player_jump_scale

signal game_start

var base_floor_timer_time : Array = [2.5,4]
var base_platform_timer_time : Array = [2,3]
var base_high_floor_timer_time : Array = [1,2]
var base_coin_timer_time = 1

var base_coin_position_change_delta = 400

var player


# Called when the node enters the scene tree for the first time.
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
	print(xform , " " , yform)

	if yform > 1280:
		var objects_1 = %EnemySpawnPositions.get_children()
		for node in objects_1:
			node.position.y *= yatio
		var objects_2 = %CoinSpawnPositions.get_children()
		for node in objects_2:
			node.position.y *= yatio
		var nodes_to_move =[%StartPosition,%FloorCoinDespawn,%PlayerFell]
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = [%FloorCoinDespawn]
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var objects_1 = %EnemySpawnPositions.get_children()
		for node in objects_1:
			node.position.x *= xatio
		var objects_2 = %CoinSpawnPositions.get_children()
		for node in objects_2:
			node.position.x *= xatio
		var nodes_to_move =[%PlayerFell]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = [%PlayerFell]
		for node in nodes_to_scale:
			node.scale.x *= xatio

	if get_node_or_null("ParallaxBackground")!=null:
		if xatio <= 1:
			xatio = 1
		if yatio <= 1:
			yatio = 1
		var parallax_background = get_node_or_null("ParallaxBackground")
		parallax_background.get_resize_dimensions(xatio,yatio)

	%EnemyAnimationArea.body_entered.connect(_on_enemy_entered)
	%PlayerFell.body_entered.connect(_on_player_fall_out)
	%ObjectSpawn.set_xatio(xatio)

	%ObjectSpawn.set_new_times(base_floor_timer_time,base_platform_timer_time,base_high_floor_timer_time)
	player_jump_scale = yatio


	%FloorTimer.wait_time = base_floor_timer_time[0]
	%PlatformTimer.wait_time = base_platform_timer_time[0]
	%HighPlatformTimer.wait_time = base_high_floor_timer_time[0]
	%CoinTimer.wait_time = base_coin_timer_time
	player = player_scene.instantiate()
	player.position = %StartPosition.position
	player.motion_mode = 1
	player.set_yatio(player_jump_scale)
	player.set_xpos(%StartPosition.position.x)
	player.set_collision_disabled(true)
	add_child.call_deferred(player)


	pass # Replace with function body.


func _process(_delta):

	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	game_start.emit()
	player.set_collision_disabled(false)
	player.motion_mode = 0
	pass

func _on_advance_level():
	print('here')
	for time in base_floor_timer_time:
		time *= pow(1.05,HUD.return_game_level())
	for time in base_platform_timer_time:
		time *= pow(1.05,HUD.return_game_level())
	for time in base_high_floor_timer_time:
		time *= pow(1.05,HUD.return_game_level())
	%ObjectSpawn.set_new_times(base_floor_timer_time,base_platform_timer_time,base_high_floor_timer_time)
	#%FloorTimer.wait_time = base_floor_timer_time * pow(1.05,HUD.return_game_level())
	#%PlatformTimer.wait_time = base_platform_timer_time * pow(1.05,HUD.return_game_level())
	#%HighPlatformTimer.wait_time = base_high_floor_timer_time * pow(1.05,HUD.return_game_level())
	#%CoinTimer.wait_time = base_coin_timer_time * pow(1.05,HUD.return_game_level())
	var old_speed = %ObjectSpawn.get_object_speed()
	%ObjectSpawn.set_object_speed(old_speed*pow(1.05,HUD.return_game_level()))
	for node in %ObjectSpawn.get_children():
		node.speed = node.base_speed * old_speed * pow(1.05,HUD.return_game_level())
	pass

func _on_player_fall_out(body):
	if body is PerryRunPlayer:
		HUD.update_lives()

func _on_game_over():
	pass

func _on_enemy_entered(body):
	if body.is_in_group("enemy"):
		body.animate()
