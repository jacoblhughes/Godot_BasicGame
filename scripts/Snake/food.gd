
extends Node2D

var food_position := Vector2()
var size := SnakeVariables.snakecellsize
var color := SnakeVariables.YELLOW

@onready var my_sprite: Sprite2D
signal SnakeFoodReady

# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $AppleSprite

	SnakeFoodReady.emit()
	pass # Replace with function body.

func get_rect() -> Rect2:
	return Rect2(food_position,size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
