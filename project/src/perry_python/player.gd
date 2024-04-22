class_name SnakeBoy
extends Minisnake

@onready var my_sprite : Sprite2D

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node("Sprite2D"):
		my_sprite = %Sprite2D

	pass # Replace with function body.
