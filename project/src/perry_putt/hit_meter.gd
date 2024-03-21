extends CanvasLayer

var direction = 1
var speed = 2
var meter_status = false

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if meter_status:
		%ProgressBar.value += speed * direction
		if %ProgressBar.value >= %ProgressBar.max_value or %ProgressBar.value <= 0:
			direction *= -1
	pass

func start_meter():

	meter_status = true

	
func stop_meter():
	meter_status = false

		
func return_meter():
	return %ProgressBar.value
