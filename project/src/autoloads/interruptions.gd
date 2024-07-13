extends CanvasLayer

@export var interruptions_timer : Timer

signal glitch_switch(val)
var glitch_upper_limit = 10
var glitch_lower_limit = 5
var show_time  = false
var glitch_active = false
@export var glitch_timer : Timer
@export var glitch_label : Label

@export var spraying_wiping_timer : Timer
@export var spraying_wiping_animation : AnimatedSprite2D

func _ready():
	glitch_timer.timeout.connect(_on_glitch_timer_timeout)
	interruptions_timer.timeout.connect(_on_interruptions_timer_timeout)
	_set_glitch_timer()
	pass # Replace with function body.

func _process(delta):

	if glitch_active == false and !glitch_timer.is_stopped() and glitch_timer.get_time_left() <=3 and glitch_timer.wait_time > 1:
		show_time = true
		self.show()
	if glitch_active == true and !glitch_timer.is_stopped() and glitch_timer.get_time_left() <=3 and glitch_timer.wait_time > 1:
		show_time = true
		self.show()
	if show_time and glitch_active == false:
		glitch_label.text = "Glitch time in:  %.2f" % glitch_timer.get_time_left()
	if show_time and glitch_active:
		glitch_label.text = "Glitch back in:  %.2f" % glitch_timer.get_time_left()
	pass

func _on_glitch_timer_timeout():
	if show_time and self.visible==true:
		self.hide()
		show_time = false
	glitch_active = !glitch_active
	glitch_switch.emit(glitch_active)
	_set_glitch_timer()
	glitch_timer.start()

func start_glitch_timer():
	_set_glitch_timer()
	glitch_timer.start()

func _set_glitch_timer():
	var new_wait_time = 0
	if glitch_active:
		new_wait_time = 5
	else:
		new_wait_time = randi_range(glitch_lower_limit,glitch_upper_limit)
	glitch_timer.wait_time = new_wait_time

func reset_glitch():
	glitch_active = false
	show_time = false
	glitch_timer.stop()
	glitch_timer.wait_time = 1
	self.hide()

func _on_interruptions_timer_timeout():
	var choose_interruption = 1
	
func start_interruptions_timer():
	self.show()
	print('here')
	spraying_wiping_animation.play("spraying")
	await spraying_wiping_animation.animation_finished
	spraying_wiping_animation.play("first_pass")
	await spraying_wiping_animation.animation_finished
	spraying_wiping_animation.play("second_pass")
	await spraying_wiping_animation.animation_finished
	spraying_wiping_animation.play("third_pass")
	await spraying_wiping_animation.animation_finished
	self.hide()
