extends Node2D

var width
var height
var sizewidth 
var sizeheight
var originalx
var originaly

# Called when the node enters the scene tree for the first time.
func _ready():
	SnakeVariables._set_play_area_size(GameManager.get_play_area_size_from_HUD())
	SnakeVariables._set_play_area_position(GameManager.get_play_area_position_from_HUD())
	var cellX = GameManager.get_play_area_size_from_HUD().x/SnakeVariables.snakecells
	var cellY = GameManager.get_play_area_size_from_HUD().y/SnakeVariables.snakecells
	SnakeVariables.set_snake_cell_size(Vector2(cellX,cellY))
	sizewidth = SnakeVariables.GRID_SIZE.x/SnakeVariables.snakecells
	sizeheight = SnakeVariables.GRID_SIZE.y/SnakeVariables.snakecells
	width = SnakeVariables.GRID_SIZE.x
	height = SnakeVariables.GRID_SIZE.y
	originalx = SnakeVariables.GRID_POSITION.x
	originaly = SnakeVariables.GRID_POSITION.y

	pass
	
func _draw():

	for i in SnakeVariables.snakecells+1:

		var vectortest = Vector2(i*sizewidth+originalx,0+originaly)
		var vectortest1 = Vector2(i*sizewidth+originalx,height+originaly)
		draw_line(vectortest,vectortest1,SnakeVariables.BLUE)
	for i in SnakeVariables.snakecells+1:
		var vectortest2 = Vector2(0+originalx,i*sizeheight+originaly)
		var vectortest3 = Vector2(width+originalx,i*sizeheight+originaly)
		draw_line(vectortest2,vectortest3,SnakeVariables.BLUE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
