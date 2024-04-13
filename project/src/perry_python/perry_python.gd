class_name Snake
extends Node2D



#var head := Minisnake.new()
@onready var head
@onready var head_scene = preload("res://src/perry_python/player.tscn")
var minisnakes := [] as Array[Minisnake]

var next_direction = Vector2.ZERO
var curr_direction = Vector2.ZERO

var snake_length = 0
var play_area_min 
signal hit(minisnake_hit: Minisnake)
var snake_timer
var isFirst = true
var isFirstminiSnake = true
@onready var grid : Node2D
@onready var food_spawner :Node2D 
var level_value = 1
var head_original_x
var head_original_y
var score_value = 1

var original_snake_time = .75


var snake_cells = 8
var snake_cell_size := Vector2(0,0)
var game_size := Vector2(0,0)
var game_position := Vector2(0,0)
var cell_size
var sizewidth 
var sizeheight
var originalx
var originaly
var width
var height
var BLUE  = Color.WHITE

signal dimensions_ready

var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable

func _draw():

	if cell_size:

		for i in snake_cells+1:

			var vectortest = Vector2(i*cell_size.x+game_position.x,0+game_position.y)
			var vectortest1 = Vector2(i*cell_size.x+game_position.x,height+game_position.y)
			draw_line(vectortest,vectortest1,BLUE)
			
		for i in snake_cells+1:
			var vectortest2 = Vector2(0+game_position.x,i*cell_size.y+game_position.y)
			var vectortest3 = Vector2(width+game_position.x,i*cell_size.y+game_position.y)
			draw_line(vectortest2,vectortest3,BLUE)


func _ready():
	var game_area = Vector2(HUD.get_play_area_size().x,HUD.get_play_area_size().x)
	var left_over = (HUD.get_play_area_size().y/2) - (HUD.get_play_area_size().x/2)
	var game_position = Vector2(HUD.get_play_area_position().x,HUD.get_play_area_position().y+left_over)
	cell_size = Vector2(game_area.x/snake_cells,game_area.y/snake_cells)

	set_play_area_size(game_area)
	set_play_area_position(game_position)
	set_snake_cell_size(cell_size)

	snake_timer = %SnakeTimer
	snake_timer.timeout.connect(_on_snake_move_timer_timeout)
	
	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280
	print(xform , " " , yform)
	if yform > 1280:
		%Camera2D.enabled = true
#		%Camera2D.zoom.y = yform/1280

	if xform > 720:
		var nodes_to_move =[]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.x *= xatio
	
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()
	
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	food_spawner = %spawner_food
	head  = head_scene.instantiate()
	food_spawner.food_eaten.connect(_on_food_eaten)
	get_parent().add_child.call_deferred(head)
	snake_timer.wait_time = original_snake_time
	dimensions_ready.emit()
	_on_grid_ready()
	


func _process(_delta):
	if head:
		head.position = head.curr_position + return_snake_cell_size()/2

	var test_children = get_tree().get_nodes_in_group("snakeLengths")
	for child in test_children:
		if child:
			child.position = child.curr_position + return_snake_cell_size()/2
		
	queue_redraw()

func _on_clickable_input_event(event, input_position):
	if event.pressed:
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
	var next_position = head.curr_position + (curr_direction * snake_cell_size)
	next_position.x = play_area_min.x + fposmod(next_position.x - play_area_min.x,game_size.x) 
	next_position.y = play_area_min.y + fposmod(next_position.y - play_area_min.y,game_size.y)
	head.curr_position = next_position

	for i in range(1, minisnakes.size()):
		minisnakes[i].curr_position = minisnakes[i-1].prev_position

	for i in range(1, minisnakes.size()):
		if head.get_rect().intersects(minisnakes[i].get_rect()):
			hit.emit(minisnakes[i])
			break
			
func _on_snake_move_timer_timeout():
	if(GameManager.get_game_enabled()):
		move()
	pass # Replace with function body.

func grow() -> void:


	var new_head = preload("res://src/perry_python/segment.tscn").instantiate()
	var last_head :=minisnakes.back() as SnakeBoy
	new_head.curr_position = last_head.curr_position
#	new_head.color = SnakeVariables.BLUE
	new_head.size = snake_cell_size
	new_head.add_to_group("snakeLengths")
	minisnakes.push_back(new_head)

	get_parent().get_node("body").add_child.call_deferred(new_head)

	
func _on_hit(mini:Minisnake) -> void:
	await get_tree().process_frame
	for minisnake in minisnakes:
		minisnake.go_to_previous_position()
	HUD.update_lives(-1)

	
func _on_play_button_pressed():
		snake_timer.start()
		GameManager.set_game_enabled(true)

func _on_game_over():
	
	snake_timer.stop()
	minisnakes = []
	GameStartGameOver.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()
	pass

func _on_grid_ready():
	head.size = snake_cell_size
	head.curr_position = play_area_min + Vector2(game_size.x/2,game_size.y/2)
#	head.SnakePartReady.connect(_on_head_ready)
	hit.connect(_on_hit)
	minisnakes.push_front(head)

func _on_food_eaten():
	HUD.update_score(score_value)
	if HUD.check_advance_level():
		advance_level()
	
func advance_level():
	snake_timer.wait_time = original_snake_time * pow(.95,HUD.get_game_level())



func set_play_area_size(value):
	game_size = value

func return_play_area_size():
	return game_size

func set_play_area_position(value):
	game_position = value

func return_play_area_position():
	return game_position

func set_snake_cell_size(value):
	snake_cell_size = value

func return_snake_cell_size():
		return cell_size

func return_snake_cells():
	return snake_cells
