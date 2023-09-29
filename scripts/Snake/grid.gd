extends Node2D

var width
var height
var sizewidth 
var sizeheight
var originalx
var originaly
# Called when the node enters the scene tree for the first time.
func _ready():
	SnakeVariables._set_play_area_size($Play_Area.size)
	SnakeVariables._set_play_area_position($Play_Area.position)
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
		draw_line(vectortest,vectortest1,'white')
	for i in SnakeVariables.snakecells+1:
		var vectortest2 = Vector2(0+originalx,i*sizeheight+originaly)
		var vectortest3 = Vector2(width+originalx,i*sizeheight+originaly)
		draw_line(vectortest2,vectortest3,'white')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
