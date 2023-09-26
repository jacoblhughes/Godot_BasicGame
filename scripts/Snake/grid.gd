extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _draw():
	var vectortest = Vector2(0,0)
	var vectortest1 = Vector2(320,500)
	draw_line(vectortest,vectortest1,'white')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
