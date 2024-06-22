extends Area2D

@export var drawings_animation : AnimatedSprite2D
@export var card_animation : AnimatedSprite2D
var flip_timer : Timer
var remove_timer : Timer
var selected : bool
var selection : int
signal card_selected(card_node)
signal flip_card_animation_finished
signal flip_back_card_animation_finished

func _ready():
	flip_timer = Timer.new()
	flip_timer.wait_time = 1.0
	flip_timer.timeout.connect(_on_flip_timer_timeout)
	flip_timer.one_shot = true
	remove_timer = Timer.new()
	remove_timer.wait_time = 0.5
	remove_timer.timeout.connect(_on_remove_timer_timeout)
	remove_timer.one_shot = true
	card_animation.animation_finished.connect(_on_card_animation_finished)
	add_child(flip_timer)
	add_child(remove_timer)
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed and !selected:
		card_selected.emit(self)
		
func flip_card():
	selected = true
	drawings_animation.play("default")
	card_animation.play("default")

func flip_card_back():
	flip_timer.start()

func _on_flip_timer_timeout():
	drawings_animation.play_backwards("default")
	card_animation.play_backwards("default")


func _on_card_animation_finished():
	if selected:
		flip_card_animation_finished.emit()
		selected = false
	if !selected:
		flip_back_card_animation_finished.emit()

func remove_card():
	remove_timer.start()
	
func _on_remove_timer_timeout():
	queue_free()
