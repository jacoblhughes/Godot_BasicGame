extends Node2D
var score_value = -1
var initial_score = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	%Hole.ball_sank.connect(_on_perry_ball_sank)

	%HitMeter.send_value.connect(_on_hit_meter_value)
	_game_initialize()
	pass

func _game_initialize():
	HUD.reset_score()
	HUD.update_score(initial_score)
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_level(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_pressed("hit_space") and !%HitMeter.meter_status:

		%HitMeter.start_meter()
		
	elif Input.is_action_just_pressed("hit_space") and %HitMeter.meter_status:
		%HitMeter.stop_meter()
		%PerryBall.swing(%HitMeter.return_meter())


func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_perry_ball_sank():
	if(GameManager.get_game_enabled()):
		_game_over()
		
func _game_over():
	GameManager.set_game_enabled(false)
	HUD.set_gameover_panel(true)

	%PerryBall.linear_velocity = Vector2.ZERO
	GameManager.check_highscore_and_rank()

func _on_hit_meter_value(_progress_value):
	HUD.update_score(score_value)
	if HUD.return_score() < 1:
		_game_over()
		
