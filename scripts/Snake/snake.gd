class_name Snake extends Node2D

var head := Minisnake.new()
var minisnakes := [] as Array[Minisnake]

var next_direction = Vector2.ZERO
var curr_direction = Vector2.ZERO


var snake_length = 0
var play_area_min = Vector2(40, 160)
signal hit(minisnake_hit: Minisnake)

func _ready():

	head.size = SnakeVariables.snakecellsize
	head.color = SnakeColors.DARKBLUE
	head.curr_position = play_area_min + Vector2(SnakeVariables.GRID_SIZE.x/2,SnakeVariables.GRID_SIZE.y/2)
	minisnakes.push_front(head)

	hit.connect(_on_hit)

#	tween_move = create_tween().set_loops()
#	tween_move.tween_callback(move).set_delay(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	queue_redraw()
	pass
	
func _draw():

	for minisnake in minisnakes:
		draw_rect(minisnake.get_rect(),minisnake.color)


func _input(event):

	if Input.is_action_pressed("move_right"):
		next_direction = Vector2.RIGHT
	if Input.is_action_pressed("move_left"):
		next_direction = Vector2.LEFT
	if Input.is_action_pressed("move_down"):
		next_direction = Vector2.DOWN
	if Input.is_action_pressed("move_up"):
		next_direction = Vector2.UP

func move() -> void:

	curr_direction = next_direction
	var next_position = head.curr_position + (curr_direction * SnakeVariables.snakecellsize)
	next_position.x = 40 + fposmod(next_position.x - 40,SnakeVariables.GRID_SIZE.x) 
	next_position.y = 160 + fposmod(next_position.y - 160,SnakeVariables.GRID_SIZE.y)
	head.curr_position = next_position

	for i in range(1, minisnakes.size()):
		minisnakes[i].curr_position = minisnakes[i-1].prev_position

	for i in range(1, minisnakes.size()):
		if head.get_rect().intersects(minisnakes[i].get_rect()):
			hit.emit(minisnakes[i])
			break
			
func _on_snake_move_timer_timeout():
	move()
	pass # Replace with function body.

func grow() -> void:

	var minisnake := Minisnake.new()
	var last_minisnake := minisnakes.back() as Minisnake
	minisnake.curr_position = last_minisnake.curr_position
	minisnake.color = SnakeColors.BLUE
	minisnake.size = SnakeVariables.snakecellsize

	minisnakes.push_back(minisnake)

func _on_hit(mini:Minisnake) -> void:
	get_parent().get_node("Snake_Move_Timer").stop()
	
	await get_tree().process_frame
	
	for minisnake in minisnakes:
		minisnake.go_to_previous_position()
