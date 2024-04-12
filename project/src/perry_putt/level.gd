extends Node2D
var score_value = -1
signal ball_sank
signal game_over


# Called when the node enters the scene tree for the first time.
func _ready():
	
	%Hole.ball_sank.connect(_on_ball_sank)
	%HitMeter.send_value.connect(_on_hit_meter_value)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ball_sank():
	if(GameManager.get_game_enabled()):
		%PerryBall.linear_velocity = Vector2.ZERO
		ball_sank.emit()
		queue_free()
		
func _on_hit_meter_value(_progress_value):
	HUD.update_score(score_value)
	if HUD.return_score() < 1:
		game_over.emit()
		
