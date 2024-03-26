extends Node2D

var initial_score = 100
# Called when the node enters the scene tree for the first time.
func _ready():
#	%Hole.ball_sank.connect(_on_perry_ball_sank)


	_game_initialize()
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


