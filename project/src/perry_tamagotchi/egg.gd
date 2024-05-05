extends Area2D

var clicks = 0
var hatched = false

signal egg_hatched()
# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func _on_clickable_input_event(event, input_position):
	if event.pressed and !hatched and GameManager.get_game_enabled():
			clicks += 1
	if event.pressed and !hatched and clicks % 5 == 0 and clicks>0 and GameManager.get_game_enabled():
		%AnimatedSprite2D.frame += 1
		if %AnimatedSprite2D.frame == 4:
			await get_tree().create_timer(2).timeout
			hatched = true
			%AnimatedSprite2D.play("hatching")
			%AnimatedSprite2D.animation_finished.connect(_on_hatching_animation_finished)
			HUD.clickable_input_event.disconnect(_on_clickable_input_event)
	pass

func _on_hatching_animation_finished():
	await get_tree().create_timer(2).timeout
	egg_hatched.emit()
	queue_free()
