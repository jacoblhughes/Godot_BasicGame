extends CanvasLayer

var direction = 1
var speed = 2
var meter_status = false

signal send_value(progress_value)
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
	send_value.emit(%ProgressBar.value)

func clear():
	%ProgressBar.value = 0


func _on_texture_button_pressed():

	if !meter_status:
		start_meter()
	else:
		stop_meter()
	pass # Replace with function body.
