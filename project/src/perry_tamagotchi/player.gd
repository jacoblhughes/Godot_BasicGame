extends Area2D

var tween_positions : Array
var current_tween_position = null
var new_tween_position = null
var new_tween_position_selection = null
var current_tween_position_selection = null
@export var tween_timer : Timer
func _ready():
	current_tween_position = position
	tween_timer.timeout.connect(_on_tween_timer_timeout)


func _physics_process(delta):
	if current_tween_position_selection != new_tween_position_selection and new_tween_position_selection != null:
		var direction = new_tween_position - current_tween_position
		var direction_normalized = direction.normalized()

		var angle = rad_to_deg(direction_normalized.angle_to(Vector2.RIGHT))
		if angle < 0:
			angle += 360
		print(angle)
		var direction_key = ""
		if angle < 22.5 or angle >= 337.5:
			direction_key = "right"
		elif angle < 67.5:
			direction_key = "up_right"
		elif angle < 112.5:
			direction_key = "up"
		elif angle < 157.5:
			direction_key = "up_left"
		elif angle < 202.5:
			direction_key = "left"
		elif angle < 247.5:
			direction_key = "down_left"
		elif angle < 292.5:
			direction_key = "down"
		elif angle < 337.5:
			direction_key = "down_right"
		%AnimatedSprite2D.animation = "walk_"+direction_key
	pass

func assign_tween_positions(array):
	tween_positions = array
	tween_timer.start()

func _on_tween_timer_timeout():
	new_tween_position_selection = randi_range(0,len(tween_positions)-1)
	while new_tween_position_selection == current_tween_position_selection:
		new_tween_position_selection = randi_range(0,len(tween_positions)-1)
	new_tween_position = tween_positions[new_tween_position_selection]
	var tween = create_tween()
	tween.finished.connect(_on_tween_completed)
	tween.tween_property(self, "position", new_tween_position, 2).set_ease(Tween.EASE_OUT)

func _on_tween_completed():
	current_tween_position = new_tween_position
	current_tween_position_selection = new_tween_position_selection
	var new_wait_time = randi_range(1,5)
	tween_timer.wait_time = new_wait_time
	tween_timer.start()

func hunger_satisfy():

	pass
