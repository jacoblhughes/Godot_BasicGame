extends Path3D
var progress_direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


func _process(delta):
	var progress = $PathFollow3D.progress_ratio
	progress += progress_direction * 0.25 * delta
	
	if progress >= 1.0 or progress <= 0.0:
		progress_direction *= -1  # Reverse direction
	
	$PathFollow3D.progress_ratio = clamp(progress, 0.0, 1.0)

func return_progress_ratio_position():
	return $PathFollow3D.position
