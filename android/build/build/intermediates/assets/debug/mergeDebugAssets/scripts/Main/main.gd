extends Control



# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			print(event.position)



			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	pass
