extends Area2D
class_name PerryRunCoin

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 5 * -1
	pass

func _on_body_entered(body):
	if body is PerryRunPlayer:
		HUD.update_score()
		queue_free()
