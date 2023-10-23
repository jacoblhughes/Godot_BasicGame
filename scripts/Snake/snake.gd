class_name Snake
extends Node2D



#var head := Minisnake.new()
var head
var minisnakes := [] as Array[Minisnake]

var next_direction = Vector2.ZERO
var curr_direction = Vector2.ZERO
var png_size = 150
var game_disabled = true
var snake_length = 0
var play_area_min = GameManager.get_play_area_position_from_HUD()
signal hit(minisnake_hit: Minisnake)
var SnakeTimer
var isFirst = true
var isFirstminiSnake = true

@onready var SPAWNSIGNALS = get_parent().get_node("spawner_food")
func _ready():
	SnakeTimer = get_parent().get_node("Snake_Move_Timer")
	GameManager.startButtonPressed.connect(_on_play_button_pressed)
	GameManager.resetButtonPressed.connect(on_reset_button_reset_button_pressed)
	SPAWNSIGNALS.PlayerWin.connect(_on_player_win)
	head  = preload("res://scenes/Snake/Player.tscn").instantiate()
	get_parent().add_child.call_deferred(head)
	head.size = SnakeVariables.snakecellsize
#	head.color = SnakeVariables.DARKBLUE
	head.curr_position = play_area_min + Vector2(SnakeVariables.GRID_SIZE.x/2,SnakeVariables.GRID_SIZE.y/2)
	
	head.scale.x = SnakeVariables.snakecellsize.x/png_size
	head.scale.y = SnakeVariables.snakecellsize.y/png_size
	minisnakes.push_front(head)

	hit.connect(_on_hit)
	print(head.get_children())
#	tween_move = create_tween().set_loops()
#	tween_move.tween_callback(move).set_delay(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if head:
		head.position = head.curr_position + SnakeVariables.get_snake_cell_size()/2

	var test_children = get_tree().get_nodes_in_group("snakeLengths")
	for child in test_children:
		if child:
			child.position = child.curr_position + SnakeVariables.get_snake_cell_size()/2
		
	queue_redraw()
	
func _draw():
	pass
#	for minisnake in minisnakes:
#
#		draw_rect(minisnake.get_rect(),minisnake.color)


func _input(event):
	
	if event is InputEventScreenTouch and event.pressed == true:
		var click_position = event.position
		var head_position = head.position
		var distance = click_position - head_position

		if abs(distance.x) > abs(distance.y):
			if(distance.x<0):
				head.my_sprite.rotation = 0
				next_direction = Vector2.LEFT
				head.my_sprite.rotation = -90
				head.my_sprite.flip_v = false
			else:
				head.my_sprite.rotation = 0
				next_direction = Vector2.RIGHT
				head.my_sprite.rotation = 90
				head.my_sprite.flip_v = false
				
		elif abs(distance.x) < abs(distance.y):
			if(distance.y<0):
				head.my_sprite.rotation = 0
				next_direction = Vector2.UP
				head.my_sprite.rotation = 0
				head.my_sprite.flip_v = false
			else:
				head.my_sprite.rotation = 0
				next_direction = Vector2.DOWN
				head.my_sprite.flip_v = true

#	if Input.is_action_pressed("move_right"):
#		head.my_sprite.rotation = 0
#		next_direction = Vector2.RIGHT
#		head.my_sprite.rotation = 90
#		head.my_sprite.flip_v = false
#	if Input.is_action_pressed("move_left"):
#		head.my_sprite.rotation = 0
#		next_direction = Vector2.LEFT
#		head.my_sprite.rotation = -90
#		head.my_sprite.flip_v = false
#	if Input.is_action_pressed("move_down"):
#		head.my_sprite.rotation = 0
#		next_direction = Vector2.DOWN
#		head.my_sprite.flip_v = true
#	if Input.is_action_pressed("move_up"):
#		head.my_sprite.rotation = 0
#		next_direction = Vector2.UP
#		head.my_sprite.rotation = 0
#		head.my_sprite.flip_v = false
func move() -> void:

	curr_direction = next_direction
	var next_position = head.curr_position + (curr_direction * SnakeVariables.snakecellsize)
	next_position.x = play_area_min.x + fposmod(next_position.x - play_area_min.x,SnakeVariables.GRID_SIZE.x) 
	next_position.y = play_area_min.y + fposmod(next_position.y - play_area_min.y,SnakeVariables.GRID_SIZE.y)
	head.curr_position = next_position

	for i in range(1, minisnakes.size()):
		minisnakes[i].curr_position = minisnakes[i-1].prev_position

	for i in range(1, minisnakes.size()):
		if head.get_rect().intersects(minisnakes[i].get_rect()):
			hit.emit(minisnakes[i])
			break
			
func _on_snake_move_timer_timeout():
	if(!game_disabled):
		move()
	pass # Replace with function body.

func grow() -> void:

#	var minisnake := Minisnake.new()
#	var last_minisnake := minisnakes.back() as Minisnake
#	minisnake.curr_position = last_minisnake.curr_position
#	minisnake.color = SnakeVariables.BLUE
#	minisnake.size = SnakeVariables.snakecellsize
#	minisnakes.push_back(minisnake)
	var new_head = preload("res://scenes/Snake/Segment.tscn").instantiate()
	var last_head :=minisnakes.back() as SnakeBoy
	new_head.curr_position = last_head.curr_position
#	new_head.color = SnakeVariables.BLUE
	new_head.size = SnakeVariables.snakecellsize
	new_head.add_to_group("snakeLengths")
	minisnakes.push_back(new_head)

	get_parent().get_node("body").add_child.call_deferred(new_head)
	new_head.scale.x = SnakeVariables.snakecellsize.x/png_size
	new_head.scale.y = SnakeVariables.snakecellsize.y/png_size
func _on_hit(mini:Minisnake) -> void:

	
	await get_tree().process_frame
	
	for minisnake in minisnakes:
		minisnake.go_to_previous_position()
	game_over()
func _on_play_button_pressed():
		SnakeTimer.start()
		game_disabled = false


func on_reset_button_reset_button_pressed():
	SnakeTimer.stop()
	
	# Remove all minisnakes from the scene
#	for minisnake in minisnakes:
#		minisnake.queue_free()
	for minisnake in minisnakes:
		if isFirstminiSnake:
			isFirstminiSnake = false
			continue
		minisnake.queue_free()
	var bodyNode = get_parent().get_node("body")
	for child in bodyNode.get_children():
		if isFirst:
			isFirst = false
			continue
		child.queue_free()
	# Clear the minisnakes array
	minisnakes.clear()
	
	# Reset head position and add to minisnakes list
	head.curr_position = play_area_min + Vector2(SnakeVariables.GRID_SIZE.x/2,SnakeVariables.GRID_SIZE.y/2)
	minisnakes.push_front(head)
	
	# Reset movement directions
	next_direction = Vector2.ZERO
	curr_direction = Vector2.ZERO
	
	# Reset game state
	_change_game_disabled(true)
	
	# Reset the score displayed in HUD
	GameManager.set_new_score(0)
	isFirst = true
	isFirstminiSnake = true
func game_over():
	SnakeTimer.stop()
	GameManager.set_new_score(0)
	minisnakes = []
	pass

func _change_game_disabled(status):
	game_disabled = status

func _on_player_win():
	pass
