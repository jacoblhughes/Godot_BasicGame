extends Node2D

var head
var body
@export var head_scene : PackedScene
@export var body_scene : PackedScene
var minisnakes := [] as Array[Minisnake]


var snake_timer
var isFirst = true
var isFirstminiSnake = true
@onready var grid : Node2D
@onready var food_spawner :Node2D

var head_original_x
var head_original_y
var next_direction = Vector2.ZERO
var curr_direction = Vector2.ZERO


var base_snake_timer_time = .7
var snake_cells = 10
var game_area
var snake_cell_size := Vector2(0,0)
var game_position := Vector2(0,0)
var left_over

signal dimensions_ready

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3



func _ready():


	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	var advance_level_callable = Callable(self,"_on_advance_level")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value,advance_level_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()

	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280

	if yform > 1280:
		pass

	if xform > 720:

		var nodes_to_move =[]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.x *= xatio

	game_area = Vector2(HUD.get_play_area_size().x,HUD.get_play_area_size().x)
	left_over = (HUD.get_play_area_size().y/2) - (HUD.get_play_area_size().x/2)
	game_position = Vector2(HUD.get_play_area_position().x,HUD.get_play_area_position().y+left_over)
	snake_cell_size = Vector2(game_area.x/snake_cells,game_area.y/snake_cells)

	set_play_area_size(game_area)
	set_play_area_position(game_position)
	set_snake_cell_size(snake_cell_size)

	snake_timer = %SnakeTimer
	snake_timer.timeout.connect(_on_snake_move_timer_timeout)
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	food_spawner = %FoodSpawner

	body = %Body
	head = %Player
	food_spawner.food_eaten.connect(_on_food_eaten)
	head.update_scale(snake_cell_size)
	head.curr_position = game_position + Vector2(game_area.x/2,game_area.y/2)
	snake_timer.wait_time = base_snake_timer_time
	head.hit.connect(_on_hit)
	minisnakes.push_front(head)
	%FoodSpawner.cell_size = snake_cell_size
	dimensions_ready.emit()

func _draw():

	if snake_cell_size and snake_cells > 0:
		# Draw vertical lines
		for i in range(snake_cells + 1):
			var start_x = game_position.x + i * snake_cell_size.x
			var start = Vector2(start_x, game_position.y)
			var end = Vector2(start_x, game_position.y + snake_cells * snake_cell_size.y)
			draw_line(start, end, Color.WHITE,3)

		# Draw horizontal lines
		for i in range(snake_cells + 1):
			var start_y = game_position.y + i * snake_cell_size.y
			var start = Vector2(game_position.x, start_y)
			var end = Vector2(game_position.x + snake_cells * snake_cell_size.x, start_y)
			draw_line(start, end, Color.WHITE, 3)


func _process(_delta):
	if head:
		head.position = head.curr_position + return_snake_cell_size()/2

	var body_segments = %Body.get_children()
	for child in body_segments:
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
	next_position.x = game_position.x + fposmod(next_position.x - game_position.x,game_area.x)
	next_position.y = game_position.y + fposmod(next_position.y - game_position.y,game_area.y)
	head.curr_position = next_position

	for i in range(1, minisnakes.size()):
		minisnakes[i].curr_position = minisnakes[i-1].prev_position

	for i in range(1, minisnakes.size()):
		if head.get_rect().intersects(minisnakes[i].get_rect()):
			head.hit.emit(minisnakes[i])
			break

func _on_snake_move_timer_timeout():
	if(GameManager.get_game_enabled()):
		move()
	pass # Replace with function body.

func grow() -> void:
	var new_body = body_scene.instantiate()
	var old_body := minisnakes.back() as SnakeBoy
	new_body.curr_position = old_body.curr_position
	new_body.update_scale(snake_cell_size)
	new_body.add_to_group("snakeLengths")
	minisnakes.push_back(new_body)

	%Body.add_child.call_deferred(new_body,true)


func _on_hit(mini:Minisnake) -> void:
	await get_tree().process_frame
	for minisnake in minisnakes:
		minisnake.go_to_previous_position()
	HUD.update_lives()


func _on_play_button_pressed():
	snake_timer.start()
	GameManager.set_game_enabled(true)

	
func _on_game_over():

	snake_timer.stop()
	minisnakes = []
	pass


func _on_food_eaten():
	HUD.update_score()

func _on_advance_level():
	snake_timer.wait_time = base_snake_timer_time * pow(.95,HUD.return_game_level())

func set_play_area_size(value):
	game_area = value

func return_play_area_size():
	return game_area

func set_play_area_position(value):
	game_position = value

func return_play_area_position():
	return game_position

func set_snake_cell_size(value):
	snake_cell_size = value

func return_snake_cell_size():
	return snake_cell_size

func return_snake_cells():
	return snake_cells
