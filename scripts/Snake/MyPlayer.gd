class_name SnakeBoy
extends Minisnake

@onready var my_sprite : Sprite2D
signal SnakePartReady
# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $Sprite2D
	SnakePartReady.emit()
	# Do something with my_sprite here
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	
	pass
