extends Area2D
class_name PerryRunCoin

var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * -1
	pass

func _on_body_entered(body):
	if body is PerryRunPlayer:
		HUD.update_score()
		die()

func die():
	AudioManager.play_sound("perry_run_coin")
	queue_free()
