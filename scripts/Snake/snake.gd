extends Node2D

var head = Minisnake.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	head.size = SnakeVariables.snakecellsize
	head.color = SnakeColors.BLUE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	pass
	
func _draw():
	draw_rect(head.get_rect(),head.color)
