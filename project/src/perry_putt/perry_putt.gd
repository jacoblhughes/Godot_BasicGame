extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_game_initialize()
	pass

func _game_initialize():
	HUD.reset_score()
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
