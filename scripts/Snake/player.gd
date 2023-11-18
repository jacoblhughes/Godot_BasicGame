class_name SnakeBoy
extends Minisnake

@onready var my_sprite : Sprite2D
@export var my_sprite_size = Vector2(0,0)
signal SnakePartReady
# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node("Sprite2D"):
		my_sprite = $Sprite2D
#		my_sprite_size = my_sprite.texture.get_size()

#		SnakePartReady.emit()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	
	
	pass
