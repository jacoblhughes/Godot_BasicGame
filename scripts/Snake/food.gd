class_name Food
extends Node2D
var food_position := Vector2()
var size := SnakeVariables.snakecellsize
var color := SnakeVariables.YELLOW


func get_rect() -> Rect2:
	return Rect2(food_position,size)
