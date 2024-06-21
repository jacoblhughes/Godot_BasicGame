extends Area2D

@export var drawings_animation : AnimatedSprite2D
@export var card_animation : AnimatedSprite2D
var timer : Timer
var selected : bool

func _ready():
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	card_animation.animation_finished.connect(_on_card_animation_finished)
	pass

func _input_event(viewport, event, shape_idx):
	selected = true
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		drawings_animation.play("default")
		card_animation.play("default")


func _on_timer_timeout():
	if selected:
		drawings_animation.play_backwards("default")
		card_animation.play_backwards("default")
		selected = false
func _on_card_animation_finished():
	timer.start()
