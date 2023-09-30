extends Node2D

var food := Food.new()
@onready var snake := get_parent().get_node("snake") as Snake

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_food()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	queue_redraw()
	
	if food.get_rect().intersects(snake.head.get_rect()):
		snake.grow()
		spawn_food()
func _draw():

	draw_rect(food.get_rect(),food.color)
	
func spawn_food():
	var is_on_occupied_position = true

	while is_on_occupied_position:
		var random_position = Vector2()
		random_position.x = randi_range(0, SnakeVariables.GRID_SIZE.x - SnakeVariables.snakecellsize.x)
		random_position.y = randi_range(0, SnakeVariables.GRID_SIZE.y - SnakeVariables.snakecellsize.y)
		food.position = random_position.snapped(SnakeVariables.snakecellsize) + SnakeVariables.GRID_POSITION
		print(food.position)
		for minisnake in snake.minisnakes:
			if food.get_rect().intersects(minisnake.get_rect()):
				is_on_occupied_position = true
				break
			else:
				is_on_occupied_position = false

