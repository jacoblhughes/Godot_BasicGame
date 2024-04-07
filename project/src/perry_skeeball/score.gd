extends Area3D

signal score_zone_entered
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is PerrySkeeball:
		score_zone_entered.emit()
		body.dead_ball()
	pass # Replace with function body.
