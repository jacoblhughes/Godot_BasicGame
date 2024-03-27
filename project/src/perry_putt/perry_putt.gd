extends Node2D
@export var level_1 : PackedScene
@export var level_2 : PackedScene
@export var level_3 : PackedScene
var initial_score = 100
var current_scene
# Called when the node enters the scene tree for the first time.
func _ready():
#	%Hole.ball_sank.connect(_on_perry_ball_sank)


	_game_initialize()
	apply_level(level_1)
	pass

func _game_initialize():
	HUD.reset_score()
	HUD.update_score(initial_score)
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_level(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)


func _game_over():
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)

	%PerryBall.linear_velocity = Vector2.ZERO
	GameManager.check_highscore_and_rank()
	
func apply_level(scene):
	current_scene = scene
	var scene_instance = scene.instantiate()
	scene_instance.ball_sank.connect(_on_ball_sank)
	scene_instance.game_over.connect(_on_game_over)
	get_parent().add_child.call_deferred(scene_instance)
	
func _on_ball_sank():
	if current_scene == level_1:
		apply_level(level_2)
	if current_scene == level_2:
		apply_level(level_3)
	if current_scene == level_3:
		_game_over()
	pass
	
func _on_game_over():
	_game_over()
	pass


