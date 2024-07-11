extends CanvasLayer

signal glitch_switch(val)

var glitch_upper_limit = 10
var glitch_lower_limit = 5
var show_time  = false
var glitch_active = false


func _ready():
	$Timer.timeout.connect(_on_timer_timeout)
	_set_glitch_timer()
	pass # Replace with function body.

func _process(delta):

	if glitch_active == false and !$Timer.is_stopped() and $Timer.get_time_left() <=3 and $Timer.wait_time > 1:
		show_time = true
		self.show()
	if glitch_active == true and !$Timer.is_stopped() and $Timer.get_time_left() <=3 and $Timer.wait_time > 1:
		show_time = true
		self.show()
	if show_time and glitch_active == false:
		%Label.text = "Glitch time in:  %.2f" % $Timer.get_time_left()
	if show_time and glitch_active:
		%Label.text = "Glitch back in:  %.2f" % $Timer.get_time_left()
	pass

func _on_timer_timeout():
	if show_time and self.visible==true:
		self.hide()
		show_time = false
	glitch_active = !glitch_active
	glitch_switch.emit(glitch_active)
	_set_glitch_timer()
	$Timer.start()

func start_glitch_timer():
	$Timer.start()

func _set_glitch_timer():
	var new_wait_time = 0
	if glitch_active:
		new_wait_time = 5
	else:
		new_wait_time = randi_range(glitch_lower_limit,glitch_upper_limit)
	$Timer.wait_time = new_wait_time

func reset_glitch():
	glitch_active = false
	show_time = false
	%Timer.stop()
	%Timer.wait_time = 0
	self.hide()

