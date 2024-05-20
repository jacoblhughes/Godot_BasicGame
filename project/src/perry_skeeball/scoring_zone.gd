extends Area2D

var normal = true
var direction
var left_bound_position
var right_bound_position
var collision_shape : CollisionShape2D
var collision_shape_size

@export var worth : int
var speed : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	%Label.text = str(worth)
	body_entered.connect(_on_body_entered)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if normal:
		direction = 1
	if !normal:
		direction = -1
	if normal and position.x >= right_bound_position.x:
		normal = false
	if !normal and position.x <= left_bound_position.x:
		normal = true
	position.x += (speed * direction * delta)

	pass

func set_left_and_right_bound(left_pos, right_pos):
	left_bound_position = left_pos
	right_bound_position = right_pos
	pass

func _on_body_entered(body):
	if body is PerrySkeeballPlayer:
		HUD.update_score(worth)
		HUD.add_time_to_game_time_left(worth/2)
		body.reset_position()
