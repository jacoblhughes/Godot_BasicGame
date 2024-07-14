extends CanvasLayer

@export var interruptions_disabled : bool

@export var interruptions_timer : Timer

var interruption_type : Array = [
	'glitch',
	'spraying_wiping',
	'dead_pixels'
	]

var interruptions_lower_limit : int = 20
var interruptions_upper_limit : int = 40
var interuption_active : bool = false

signal glitch_switch(val)
var glitch_lower_limit : int = 5
var glitch_upper_limit : int = 10
var glitch_incoming : bool = false
var glitch_ending : bool = false
var glitch_active : bool = false
@export var glitch_timer : Timer
@export var glitch_incoming_timer : Timer
@export var glitch_ending_timer : Timer
@export var glitch_label : Label

@export var spraying_wiping_animation : AnimatedSprite2D

@export var dead_pixels_animation : AnimatedSprite2D

func _ready():
	%Glitch.hide()
	%SprayingWiping.hide()
	%LowPower.hide()
	%DeadPixels.hide()
	interruptions_timer.timeout.connect(_on_interruptions_timer_timeout)
	glitch_timer.timeout.connect(_on_glitch_timer_timeout)
	glitch_incoming_timer.timeout.connect(_on_glitch_incoming_timer_timeout)
	glitch_ending_timer.timeout.connect(_on_glitch_ending_timer_timeout)
	pass # Replace with function body.

func start_interruptions():
	if !interruptions_disabled:
		self.hide()
		var new_wait_time = randi_range(interruptions_lower_limit,interruptions_upper_limit)
		interruptions_timer.wait_time = new_wait_time
		interruptions_timer.start()

func _process(delta):
	if glitch_incoming:
		glitch_label.text = "Glitch time in:  %.2f" % glitch_incoming_timer.get_time_left()
	if glitch_ending:
		glitch_label.text = "Glitch back in:  %.2f" % glitch_ending_timer.get_time_left()
	pass

func _on_interruptions_timer_timeout():
	var choose_interruption =  floor(randf_range(0, interruption_type.size()))
	var interruption = interruption_type[choose_interruption]
	print(choose_interruption,"   ",interruption)
	if interruption == 'glitch':
		interuption_active = true
		%Glitch.show()
		start_glitch_incoming_timer()
	elif interruption == 'spraying_wiping':
		interuption_active = true
		%SprayingWiping.show()
		start_spraying_wiping_animation()
	elif interruption == 'dead_pixels':
		interuption_active = true
		%DeadPixels.show()
		start_dead_pixels_animation()
	self.show()
	
func start_glitch_incoming_timer():
	glitch_incoming = true
	glitch_incoming_timer.start()


func _on_glitch_incoming_timer_timeout():
	glitch_incoming = false
	start_glitch_timer()
	%Glitch.hide()
	
func start_glitch_timer():
	var new_wait_time = 0
	if glitch_active:
		new_wait_time = 5
	else:
		new_wait_time = randi_range(glitch_lower_limit,glitch_upper_limit)
	glitch_timer.wait_time = new_wait_time-3

	glitch_timer.start()
	glitch_active = true
	glitch_switch.emit(glitch_active)
	
func _on_glitch_timer_timeout():
	glitch_ending = true
	glitch_ending_timer.start()
	%Glitch.show()
	pass

func _on_glitch_ending_timer_timeout():
	glitch_active = false
	glitch_switch.emit(glitch_active)
	glitch_ending = false
	glitch_incoming = false
	%Glitch.hide()
	start_interruptions()
	pass

func start_spraying_wiping_animation():
	spraying_wiping_animation.play("spraying")
	await spraying_wiping_animation.animation_finished
	spraying_wiping_animation.play("first_pass")
	await spraying_wiping_animation.animation_finished
	spraying_wiping_animation.play("second_pass")
	await spraying_wiping_animation.animation_finished
	spraying_wiping_animation.play("third_pass")
	await spraying_wiping_animation.animation_finished
	%SprayingWiping.hide()
	start_interruptions()
	
func start_dead_pixels_animation():
	dead_pixels_animation.play("default")
	await dead_pixels_animation.animation_finished
	%DeadPixels.hide()
	start_interruptions()
	
func stop_interruptions():
	glitch_timer.stop()
	glitch_ending_timer
	glitch_incoming_timer.stop()
	interruptions_timer.stop()
	spraying_wiping_animation.stop()
	self.hide()
