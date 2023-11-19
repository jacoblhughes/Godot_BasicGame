extends Control

signal main_ready

# Called when the node enters the scene tree for the first time.
func _ready():
#	DisplayServer.window_set_size(Vector2i(1080,1920))
	main_ready.emit()

	pass # Replace with function body.

			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	pass
