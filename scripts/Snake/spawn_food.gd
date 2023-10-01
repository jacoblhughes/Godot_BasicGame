extends Node2D

#var food := Food.new()
@onready var snake := get_parent().get_node("snake") as Snake
var my_food_instance

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	HUD._set_new_score(0)
	my_food_instance = preload("res://scenes/Snake/SnakeFood.tscn").instantiate()
	spawn_food()

	my_food_instance.SnakeFoodReady.connect(_on_food_initialized)
	get_parent().add_child.call_deferred(my_food_instance)


	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	my_food_instance.position = my_food_instance.food_position
	
	queue_redraw()
	
	if my_food_instance.get_rect().intersects(snake.head.get_rect()):
		
		HUD._set_new_score(1)
		snake.grow()
		spawn_food()

func _draw():

#	draw_texture(my_food_texture,food.food_position)
	draw_rect(my_food_instance.get_rect(),my_food_instance.color)
	
func spawn_food():

	var is_on_occupied_position = true

	while is_on_occupied_position:

		var random_position = Vector2()
		random_position.x = randi_range(0, SnakeVariables.GRID_SIZE.x - SnakeVariables.snakecellsize.x)
		random_position.y = randi_range(0, SnakeVariables.GRID_SIZE.y - SnakeVariables.snakecellsize.y)
		my_food_instance.food_position = random_position.snapped(SnakeVariables.snakecellsize) + SnakeVariables.GRID_POSITION
		for minisnake in snake.minisnakes:
			if my_food_instance.get_rect().intersects(minisnake.get_rect()):
				is_on_occupied_position = true

				break
			else:
				is_on_occupied_position = false

func _on_food_initialized():
	
	pass

