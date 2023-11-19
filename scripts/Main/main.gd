extends Control

signal main_ready


# Called when the node enters the scene tree for the first time.
func _ready():
	main_ready.emit()
	pass # Replace with function body.

			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
