extends Area2D

var tween_positions : Array
var current_tween_position = null
var new_tween_position = null
var new_tween_position_selection = null
var current_tween_position_selection = null
var hunger_satisfy_node_position = null
var override_position = false
var pending_override = false
var pending_tween_position = null
@export var tween_timer : Timer

signal player_finished_eating
signal player_eating

func _ready():
	current_tween_position = position
	tween_timer.timeout.connect(_on_tween_timer_timeout)


func _physics_process(delta):

	if current_tween_position != new_tween_position and new_tween_position_selection != null:
		var direction = new_tween_position - current_tween_position
		var direction_normalized = direction.normalized()

		var angle = rad_to_deg(direction_normalized.angle_to(Vector2.RIGHT))
		if angle < 0:
			angle += 360
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

func assign_hunger_satisfy_position(pos):
	hunger_satisfy_node_position = pos

func _on_tween_timer_timeout():

	if !override_position:
		new_tween_position_selection = randi_range(0,len(tween_positions)-1)
		while new_tween_position_selection == current_tween_position_selection:
			new_tween_position_selection = randi_range(0,len(tween_positions)-1)
		new_tween_position = tween_positions[new_tween_position_selection]
		var tween = create_tween()
		tween.finished.connect(_on_tween_completed)
		tween.tween_property(self, "position", new_tween_position, 2).set_ease(Tween.EASE_OUT)
	else:
		var tween = create_tween()
		tween.finished.connect(_on_tween_completed)
		tween.tween_property(self, "position", new_tween_position, 2).set_ease(Tween.EASE_OUT)

func _on_tween_completed():

	if !override_position and !pending_override:
		current_tween_position = new_tween_position
		current_tween_position_selection = new_tween_position_selection
		var new_wait_time = randi_range(1,5)
		tween_timer.wait_time = new_wait_time
		tween_timer.start()
	elif override_position and !pending_override:
		self.hide()
		player_eating.emit()

	if pending_override:
		new_tween_position = pending_tween_position
		var new_wait_time = randi_range(1,5)
		tween_timer.wait_time = new_wait_time
		tween_timer.start()
		override_position = true
		pending_override = false
func _on_player_to_eat():
	pending_override = true
	pending_tween_position = hunger_satisfy_node_position

	pass

func _on_player_finished_eating():
	self.show()
	%AnimatedSprite2D.animation = "walk_down"
	override_position = false
	current_tween_position = new_tween_position
	current_tween_position_selection = new_tween_position_selection
	var new_wait_time = randi_range(1,5)
	tween_timer.wait_time = new_wait_time
	tween_timer.start()
	player_finished_eating.emit()
