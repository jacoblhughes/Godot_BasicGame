extends Area2D

@export var SPEED = 300
@onready var visible_notifier = $VisibleOnScreenNotifier2D

# Called when the node enters the scene tree for the first time.
func _ready():
	visible_notifier.connect("screen_exited",_on_screen_exited)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x += SPEED * delta
	pass


func _on_screen_exited():
	queue_free()
	pass # Replace with function body.


func _on_area_entered(area):
	queue_free()
	area.die()
	pass # Replace with function body.
