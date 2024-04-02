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
var BLUE  = "#FFFFFF"
# Called when the node enters the scene tree for the first time.
func _ready():


	pass

func grid_variables(new_position, new_area):
	var cellX = new_area.x/snakecells
	var cellY = new_area.y/snakecells

	sizewidth = new_area.x/snakecells
	sizeheight = new_area.y/snakecells
	width = new_area.x
	height = new_area.y
	originalx = new_position.x
	originaly = new_position.y
	grid_ready.emit()
	print('herererer')
	pass


func _draw():
	print('draw')
	for i in snakecells+1:

		var vectortest = Vector2(i*sizewidth+originalx,0+originaly)
		var vectortest1 = Vector2(i*sizewidth+originalx,height+originaly)
		draw_line(vectortest,vectortest1,BLUE)
		
	for i in snakecells+1:
		var vectortest2 = Vector2(0+originalx,i*sizeheight+originaly)
		var vectortest3 = Vector2(width+originalx,i*sizeheight+originaly)
		draw_line(vectortest2,vectortest3,BLUE)

