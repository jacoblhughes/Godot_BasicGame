extends Node2D

#var food := Food.new()
@onready var snake := get_parent() as Snake
@export var my_food : PackedScene
var my_food_instance
var tween_rotate: Tween

var radius = 10  # Radius of the circular path
var speed = 90   # Angular speed (degrees per second)
var angle = 0     # Current angle in degrees
var png_size = 150

signal food_eaten

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().dimensions_ready.connect(_on_dimensions_ready)

	pass # Replace with function body.

func _on_dimensions_ready():
	spawn_food()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	my_food_instance.position = my_food_instance.food_position + get_parent().return_snake_cell_size()/2
	
	queue_redraw()
	
	if my_food_instance.get_rect().intersects(snake.head.get_rect()):
		
		food_eaten.emit()
		my_food_instance.queue_free()
		if(HUD.return_score() > (get_parent().return_snake_cells() *2)):

			spawn_food()
			
		else:
			snake.grow()
			spawn_food()
	angle += (speed * 2)*delta
func _draw():
	pass
#	draw_texture(my_food_texture,food.food_position)
#	draw_rect(my_food_instance.get_rect(),my_food_instance.color)
	
func spawn_food():

	var is_on_occupied_position = true
	
	my_food_instance = my_food.instantiate()
	my_food_instance.SnakeFoodReady.connect(_on_food_initialized)
	my_food_instance.snake_cell_size = get_parent().return_snake_cell_size()

	
	while is_on_occupied_position:
		var random_position = Vector2()
		random_position.x = randi_range(0, get_parent().return_play_area_size().x - get_parent().return_snake_cell_size().x)
		random_position.y = randi_range(0, get_parent().return_play_area_size().y - get_parent().return_snake_cell_size().y)
		my_food_instance.food_position = random_position.snapped(get_parent().return_snake_cell_size()) + get_parent().return_play_area_position()

		for minisnake in snake.minisnakes:
			if my_food_instance.get_rect().intersects(minisnake.get_rect()):
				is_on_occupied_position = true

				break
			else:
				is_on_occupied_position = false
	get_parent().add_child.call_deferred(my_food_instance)

func _on_food_initialized():

	var x = radius * cos(deg_to_rad(angle))
	var y = radius * sin(deg_to_rad(angle))
	
	tween_rotate = create_tween()
	tween_rotate.finished.connect(_on_tween_completed)
	tween_rotate.tween_property(my_food_instance.my_sprite, "position", Vector2(x,y), .1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
#	tween_rotate.tween_property(my_food_instance.my_sprite, "position",  Vector2(320,320), 1.0)

	pass
func _on_tween_completed():
	_on_food_initialized()
	pass
