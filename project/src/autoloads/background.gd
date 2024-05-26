extends CanvasLayer
var counter = 0
var x_view = 1080
var y_view = 1920
# Called when the node enters the scene tree for the first time.
func _ready():
	#DisplayServer.window_set_size(Vector2i(x_view/2,y_view/2))
	#%ColorRect.size = Vector2(x_view/2,y_view/2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if Input.is_action_just_pressed("hit_space"):
		#DisplayServer.window_set_size(Vector2i(x_view,y_view))
		#%ColorRect.size = Vector2(x_view,y_view)
		#await get_tree().create_timer(1).timeout
		#var x = (x_view - get_viewport().get_texture().get_size().x) / 2
		#var y = (y_view - get_viewport().get_texture().get_size().y) / 2
		#var fullscreen = Rect2(0 - x, 0 - y, x_view, y_view)
		#var image = get_window().get_texture().get_image()
		#await get_tree().create_timer(1).timeout
		#DisplayServer.window_set_size(Vector2i(x_view/2,y_view/2))
#
		#var time_string = Time.get_time_string_from_system()
		#var time_parts = time_string.split(":")
#
		## Extract hour, minute, and second
		#var hour = time_parts[0]
		#var minute = time_parts[1]
		#var second = time_parts[2]
		#image.save_png("C:\\Users\\hughe\\Desktop\\save"+str(counter)+".png")
		#counter+=1
	pass
