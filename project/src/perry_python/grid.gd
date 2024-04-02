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
#func _ready():
#
#
#	pass
#
#func grid_variables(new_position, new_area):
#	var cellX = new_area.x/snakecells
#	var cellY = new_area.y/snakecells
#

#	grid_ready.emit()
#	print('herererer')
#	pass
#
#
