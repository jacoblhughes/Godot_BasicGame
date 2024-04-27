extends CanvasLayer

@export var hide_background = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if hide_background:
		Background.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
