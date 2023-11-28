extends Button

var sound : AudioStreamPlayer
var animation : AnimatedSprite2D
var animationTimer : Timer
var buttonNumber : int
var original_time = .75
signal game_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	sound = $AudioStreamPlayer
	animation = $AnimatedSprite2D
	animationTimer = $Timer
	buttonNumber = buttonNumber
	animationTimer.wait_time = original_time
	self.pressed.connect(_on_pressed)
	
func _on_animation_timer_timeout():
	sound.stop()
	animation.stop()
	animation.play('default')
	
	pass # Replace with function body.


func _on_pressed():
	sound.play()
	animation.play("pressed")
	animationTimer.start()
	game_button_pressed.emit(self)
