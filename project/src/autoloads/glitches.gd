extends CanvasLayer

var glitch_active = false

signal glitch_switch(val)

var glitch_upper_limit = 10
var glitch_lower_limit = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(_on_timer_timeout)
	_set_glitch_timer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	print('glitch')
	glitch_active = !glitch_active
	glitch_switch.emit(glitch_active)
	_set_glitch_timer()
	$Timer.start()

func start_glitch_timer():
	$Timer.start()
	print($Timer.wait_time)
	print('here')

func _set_glitch_timer():
	var new_wait_time = 0
	if glitch_active:
		new_wait_time = 5
	else:
		new_wait_time = randi_range(glitch_lower_limit,glitch_upper_limit)
	$Timer.wait_time = new_wait_time

func reset_glitch():
	glitch_active = false
