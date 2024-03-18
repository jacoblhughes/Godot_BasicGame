class_name Snake
extends Node2D



#var head := Minisnake.new()
@onready var head
@onready var head_scene = preload("res://src/perry_python/player.tscn")
var minisnakes := [] as Array[Minisnake]

var next_direction = Vector2.ZERO
var curr_direction = Vector2.ZERO
var png_size
var game_disabled = true
var snake_length = 0
var play_area_min 
signal hit(minisnake_hit: Minisnake)
var SnakeTimer
var isFirst = true
var isFirstminiSnake = true
@onready var grid : Node2D
@onready var food_spawner :Node2D 
var level_value = 1
var head_original_x
var head_original_y
var score_value = 1
var level_advance_value = 2
var original_snake_time = .75
func _ready():

	var left_over = (%ClickableArea.get_play_area_size().y/2) - (%ClickableArea.get_play_area_size().x/2)
	var new_position = Vector2(%ClickableArea.get_play_area_position().x,%ClickableArea.get_play_area_position().y+left_over)
	grid = get_parent().get_node("grid")
	grid.grid_ready.connect(_on_grid_ready)
	play_area_min = new_position
	SnakeTimer = get_parent().get_node("Snake_Move_Timer")
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.resetButtonPressed.connect(on_reset_button_reset_button_pressed)
	%ClickableArea.clickable_input_event.connect(_on_clickable_input_event)
	HUD.set_or_reset_level(level_value)
	food_spawner = get_parent().get_node("spawner_food")
	head  = head_scene.instantiate()
	food_spawner.food_eaten.connect(_on_food_eaten)
	get_parent().add_child.call_deferred(head)
	SnakeTimer.wait_time = original_snake_time

	

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

func _on_clickable_input_event(input_position):

	var click_position = input_position
	var head_position = head.position
	var distance = click_position - head_position

	if abs(distance.x) > abs(distance.y):
		head.my_sprite.rotation_degrees = 90
		if(distance.x<0):
			next_direction = Vector2.LEFT
			head.my_sprite.flip_v = true
		else:
			next_direction = Vector2.RIGHT
			head.my_sprite.flip_v = false
	elif abs(distance.x) < abs(distance.y):
		head.my_sprite.rotation_degrees = 0
		if(distance.y<0):
			next_direction = Vector2.UP
			head.my_sprite.flip_v = false
		else:
			next_direction = Vector2.DOWN
			head.my_sprite.flip_v = true

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
	var new_head = preload("res://src/perry_python/segment.tscn").instantiate()
	var last_head :=minisnakes.back() as SnakeBoy
	new_head.curr_position = last_head.curr_position
#	new_head.color = SnakeVariables.BLUE
	new_head.size = SnakeVariables.snakecellsize
	new_head.add_to_group("snakeLengths")
	minisnakes.push_back(new_head)

	get_parent().get_node("body").add_child.call_deferred(new_head)
#	new_head.scale.x = SnakeVariables.snakecellsize.x/150
#	new_head.scale.y = SnakeVariables.snakecellsize.y/150
	
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
	GameManager.reset_score()
	isFirst = true
	isFirstminiSnake = true
	
func game_over():
	
	SnakeTimer.stop()
	minisnakes = []
	HUD.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
	pass

func _change_game_disabled(status):
	game_disabled = status

func _on_player_win():
	pass

func _on_grid_ready():


	head.size = SnakeVariables.snakecellsize
	head.curr_position = play_area_min + Vector2(SnakeVariables.GRID_SIZE.x/2,SnakeVariables.GRID_SIZE.y/2)
#	head.SnakePartReady.connect(_on_head_ready)
	hit.connect(_on_hit)
#	head.scale.x = SnakeVariables.snakecellsize.x/150
#	head.scale.y = SnakeVariables.snakecellsize.y/150
	minisnakes.push_front(head)

func _on_food_eaten():
	HUD.update_score(score_value)
	if HUD.check_advance_level(level_advance_value,level_value):
		advance_level()
	
func advance_level():
	SnakeTimer.wait_time = original_snake_time * pow(.95,HUD.get_game_level())
