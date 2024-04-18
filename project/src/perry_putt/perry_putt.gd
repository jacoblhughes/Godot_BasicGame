extends Node2D
@export var level_1 : PackedScene
@export var level_2 : PackedScene
@export var level_3 : PackedScene
@export var start_level_2 = false
@export var start_level_3 = false

var current_scene


var initial_score_value = 100
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



#	%Hole.ball_sank.connect(_on_perry_ball_sank)

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

		var nodes_to_move =[]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.x *= xatio


	if start_level_2:
		apply_level(level_2)
	elif start_level_3:
		apply_level(level_3)
	else:
		apply_level(level_1)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)


func _on_game_over():
	pass


func apply_level(scene):
	current_scene = scene
	var scene_instance = scene.instantiate()
	scene_instance.ball_sank.connect(_on_ball_sank)
	scene_instance.game_over.connect(_on_game_over)
	add_child.call_deferred(scene_instance)

func _on_ball_sank():
	if current_scene == level_1:
		apply_level(level_2)
		return
	if current_scene == level_2:
		apply_level(level_3)
		return
	if current_scene == level_3:
		HUD.update_lives()
		return
	pass


