class_name Minisnake
extends Node2D
var curr_position := Vector2() : set = _set_curr_position
var prev_position := Vector2()
var size := Vector2()
var color := Color()

func get_rect() -> Rect2:

	return Rect2(curr_position,size)

func _set_curr_position(new_position: Vector2) -> void:
	prev_position = curr_position
	curr_position = new_position

func go_to_previous_position() -> void:
	curr_position = prev_position

