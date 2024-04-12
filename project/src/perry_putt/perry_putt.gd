extends Node2D
@export var level_1 : PackedScene
@export var level_2 : PackedScene
@export var level_3 : PackedScene
@export var start_level_2 = false
@export var start_level_3 = false

var current_scene


var initial_score_value = 100
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable

# Called when the node enters the scene tree for the first time.
func _ready():
#	%Hole.ball_sank.connect(_on_perry_ball_sank)

	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
#	_game_initialize()
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
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
	
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
		HUD.update_lives(-1)
		return
	pass


