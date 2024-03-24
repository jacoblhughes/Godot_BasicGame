extends Node2D

var width
var height
var sizewidth 
var sizeheight
var originalx
var originaly
@onready var player : Area2D
signal grid_ready
var snakecells = 8
# Called when the node enters the scene tree for the first time.
func _ready():
	var new_area = Vector2(%ClickableArea.get_play_area_size().x,%ClickableArea.get_play_area_size().x)
	var left_over = (%ClickableArea.get_play_area_size().y/2) - (%ClickableArea.get_play_area_size().x/2)
	var new_position = Vector2(%ClickableArea.get_play_area_position().x,%ClickableArea.get_play_area_position().y+left_over)
	SnakeVariables._set_play_area_size(new_area)
	SnakeVariables._set_play_area_position(new_position)
	var cellX = new_area.x/snakecells
	var cellY = new_area.y/snakecells
	SnakeVariables.set_snake_cell_size(Vector2(cellX,cellY))
	sizewidth = new_area.x/snakecells
	sizeheight = new_area.y/snakecells
	width = new_area.x
	height = new_area.y
	originalx = new_position.x
	originaly = new_position.y
	grid_ready.emit()
	pass
	
func _draw():

	for i in snakecells+1:

		var vectortest = Vector2(i*sizewidth+originalx,0+originaly)
		var vectortest1 = Vector2(i*sizewidth+originalx,height+originaly)
		draw_line(vectortest,vectortest1,SnakeVariables.BLUE)
		
	for i in snakecells+1:
		var vectortest2 = Vector2(0+originalx,i*sizeheight+originaly)
		var vectortest3 = Vector2(width+originalx,i*sizeheight+originaly)
		draw_line(vectortest2,vectortest3,SnakeVariables.BLUE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func return_snakecells():
	return snakecells
