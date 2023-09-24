extends PopupPanel


# Called when the node enters the scene tree for the first time.
func _ready():
	popup_window = true
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_view_high_scores_pressed():
	
	if(visible):

		visible = false
	else:

		visible = true
	

	print('heer')
	pass # Replace with function body.
