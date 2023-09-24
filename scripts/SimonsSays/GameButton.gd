extends Button

var sound : AudioStreamPlayer
var animation : AnimatedSprite2D
var faceAnimation : AnimatedSprite2D
signal game_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	sound = $Sound
	animation = $Animation
	faceAnimation = $faceAnimation
	
func _pressed():
	_on_button_pressed()

# Anonymous function (closure) to handle the button press
func _on_button_pressed():
	game_button_pressed.emit(self)
