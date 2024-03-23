extends Area2D

signal ball_sank
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if area is PlayerPuttSinkArea:
		ball_sank.emit()
	pass # Replace with function body.
