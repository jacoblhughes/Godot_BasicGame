extends Node

var snakecells = 64
@onready var PLAY_AREA : ColorRect
@onready var GRID_SIZE := Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	PLAY_AREA = get_tree().get_root().get_node("GameScene").get_node("Snake").get_node("Node2d").get_node("Play_Area")
	GRID_SIZE = Vector2(PLAY_AREA.x,PLAY_AREA.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
