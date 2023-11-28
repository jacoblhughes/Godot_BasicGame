extends Timer

var original_time = 3
var consolidated_time
# Called when the node enters the scene tree for the first time.
func _ready():
	consolidated_time = original_time
	wait_time = consolidated_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
