extends Node2D

@onready var width = $Play_Area.size.x
@onready var height = $Play_Area.size.y

@onready var cells =8

@onready var sizewidth = width/cells
@onready var sizeheight = height/cells

var originalx = 40
var originaly = 160
# Called when the node enters the scene tree for the first time.
func _ready():
	print(width)
	print(height)
	pass
	
func _draw():
	

	for i in cells+1:

		var vectortest = Vector2(i*sizewidth+originalx,0+originaly)
		var vectortest1 = Vector2(i*sizewidth+originalx,height+originaly)
		draw_line(vectortest,vectortest1,'white')
	for i in cells+1:
		var vectortest2 = Vector2(0+originalx,i*sizeheight+originaly)
		var vectortest3 = Vector2(width+originalx,i*sizeheight+originaly)
		draw_line(vectortest2,vectortest3,'white')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
