extends Node

var snakecells = 4
var snakecellsize := Vector2(0,0)
var GRID_SIZE := Vector2(0,0)
var GRID_POSITION := Vector2(0,0)

const BLUE := Color('#66999b')
const RED := Color('red')
const DARKBLUE := Color('darkblue')
const YELLOW := Color('yellow')

# Called when the node enters the scene tree for the first time.
func _ready():

	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _set_play_area_size(item):
	GRID_SIZE = Vector2(item.x,item.y)
	
func _set_play_area_position(item):
	GRID_POSITION = Vector2(item.x,item.y)

func set_snake_cell_size(item):
	snakecellsize = Vector2(item.x,item.y)

func get_snake_cell_size():
	return snakecellsize
