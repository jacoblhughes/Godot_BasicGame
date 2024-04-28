extends Control

var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.get_game_enabled():
		rotation_degrees += 50 * delta * direction
		if rotation_degrees >= 45 and direction == 1:
			direction = -1
		elif rotation_degrees <= -45 and direction == -1:
			direction = 1
		pass
