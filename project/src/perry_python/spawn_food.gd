extends Node2D

@export var my_food : PackedScene
var cell_size : Vector2
var my_food_instance
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
	print(my_food_instance.get_rect()," ",%Player.get_rect())
	if my_food_instance.get_rect().intersects(%Player.get_rect()):

		food_eaten.emit()
		my_food_instance.queue_free()
		if(HUD.return_score() > (get_parent().return_snake_cells() *2)):

			spawn_food()

		else:
			get_parent().grow()
			spawn_food()

func _draw():
	pass
#	draw_texture(my_food_texture,food.food_position)
#	draw_rect(my_food_instance.get_rect(),my_food_instance.color)

func spawn_food():

	var is_on_occupied_position = true

	my_food_instance = my_food.instantiate()
	my_food_instance.update_scale(get_parent().return_snake_cell_size())

	print(get_parent().return_snake_cell_size())

	while is_on_occupied_position:
		var random_position = Vector2()
		random_position.x = randi_range(0, get_parent().return_play_area_size().x - get_parent().return_snake_cell_size().x)
		random_position.y = randi_range(0, get_parent().return_play_area_size().y - get_parent().return_snake_cell_size().y)
		my_food_instance.food_position = random_position.snapped(get_parent().return_snake_cell_size()) + get_parent().return_play_area_position()

		for minisnake in get_parent().minisnakes:
			if my_food_instance.get_rect().intersects(minisnake.get_rect()):
				is_on_occupied_position = true

				break
			else:
				is_on_occupied_position = false
	get_parent().add_child.call_deferred(my_food_instance,true)


