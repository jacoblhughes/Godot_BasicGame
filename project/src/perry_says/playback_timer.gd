extends Timer

@onready var original_time = 1.25

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = original_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
