extends Area2D

@export var SPEED = 120
@onready var visible_notifier = $VisibleOnScreenNotifier2D
signal died
# Called when the node enters the scene tree for the first time.
func _ready():
#	visible_notifier.connect("screen_exited",_on_screen_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x -= SPEED * delta
	pass

func die():
	died.emit()
	queue_free()



func _on_body_entered(body):
	body.take_damage()
	die()
	pass # Replace with function body.
