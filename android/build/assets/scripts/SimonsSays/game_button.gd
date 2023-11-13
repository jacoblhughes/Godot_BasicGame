extends Button

var sound : AudioStreamPlayer
var animation : AnimatedSprite2D
var faceAnimation : AnimatedSprite2D
var animationTimer : Timer
var buttonNumber : int
signal game_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	sound = $Sound
	animation = $animation
	faceAnimation = $faceAnimation
	animationTimer = $animationTimer
	buttonNumber = buttonNumber
	
func _pressed():
	sound.play()
	faceAnimation.play("moving")
	animation.play("light")
	animationTimer.start()


	_on_button_pressed()

# Anonymous function (closure) to handle the button press
func _on_button_pressed():
	game_button_pressed.emit(self)


func _on_animation_timer_timeout():
	sound.stop()
	faceAnimation.stop()
	animation.stop()
	
	faceAnimation.play('default')
	animation.play('dark')
	
	pass # Replace with function body.
