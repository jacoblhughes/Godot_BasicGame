extends Button

var thisButtonSound : AudioStreamPlayer
signal this_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	thisButtonSound = $Button_Sound
	
func _pressed():
	_on_button_pressed()

# Anonymous function (closure) to handle the button press
func _on_button_pressed():
	print('Button pressed')
	this_button_pressed.emit(self)
