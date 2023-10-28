class_name SnakeBoy
extends Minisnake

@onready var my_sprite : Sprite2D
signal SnakePartReady
# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node("Sprite"):
		my_sprite = $Sprite
		SnakePartReady.emit()
		print("hererere")
	# Do something with my_sprite here
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	
	
	pass
