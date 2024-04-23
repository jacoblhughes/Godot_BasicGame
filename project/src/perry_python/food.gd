
extends Node2D

var food_position := Vector2()
var snake_cell_size := Vector2()
var radius = 10  # Radius of the circular path
var speed = 90   # Angular speed (degrees per second)
var angle = 0
var tween_rotate: Tween
var size
@onready var my_sprite: Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():

	my_sprite = $Sprite2D
	start_tween()
	pass # Replace with function body.

func get_rect() -> Rect2:
	var size =  snake_cell_size
	return Rect2(food_position,size)

func start_tween():

	var x = radius * cos(deg_to_rad(angle))
	var y = radius * sin(deg_to_rad(angle))

	tween_rotate = create_tween()
	tween_rotate.finished.connect(_on_tween_completed)
	tween_rotate.tween_property(my_sprite, "position", Vector2(x,y), .1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)


	pass
func _process(delta):

	angle += (speed * 2)*delta

func _on_tween_completed():
	start_tween()
	pass

func update_scale(val):
	size = %Sprite2D.get_texture().get_size()
	var new_scale = val/size
	set_scale(new_scale)
