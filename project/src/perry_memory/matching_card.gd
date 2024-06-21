extends Area2D

@export var drawings_animation : AnimatedSprite2D
@export var card_animation : AnimatedSprite2D



func _ready():
	drawings_animation.autoplay = false
	card_animation.autoplay = false
	pass

func _input(event):

	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		drawings_animation.play("default")
		card_animation.play("default")
