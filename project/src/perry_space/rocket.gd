extends Area2D
class_name SpaceRocket

@export var SPEED = 300
@onready var visible_notifier = $VisibleOnScreenNotifier2D
var level_advance_value = 10
var level_value = 1
var score_value = 1
@onready var perry_space : Node2D
signal enemy_hit
# Called when the node enters the scene tree for the first time.
func _ready():
	perry_space = get_parent().get_parent().get_parent().get_node("PerrySpace")
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
	if area is SpaceEnemy:
		area.die()
		enemy_hit.emit()
		queue_free()


	pass # Replace with function body.
