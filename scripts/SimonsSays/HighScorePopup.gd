extends PopupPanel

var should_be_open
# Called when the node enters the scene tree for the first time.
func _ready():
	popup_window = true
	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_view_high_scores_pressed():
	should_be_open = true
	popup()
	print('Opened popup')

	print('heer')
	pass # Replace with function body.


func _on_focus_exited():
	if should_be_open:
		hide()
		should_be_open = false
		print('Closed popup')
