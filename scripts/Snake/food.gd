class_name Food

var position := Vector2()
var size := SnakeVariables.snakecellsize
var color := SnakeColors.BLUE

func get_rect() -> Rect2:
	return Rect2(position,size)
