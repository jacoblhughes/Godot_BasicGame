
extends Node2D

var food_position := Vector2()
var snake_cell_size := Vector2()

@onready var my_sprite: Sprite2D
signal SnakeFoodReady

# Called when the node enters the scene tree for the first time.
func _ready():
	print('food should be ready')
	my_sprite = $Sprite2D

	SnakeFoodReady.emit()
	pass # Replace with function body.

func get_rect() -> Rect2:
	var size =  snake_cell_size
	return Rect2(food_position,size)

