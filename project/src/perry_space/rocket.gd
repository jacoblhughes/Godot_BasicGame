extends Area2D
class_name SpaceRocket

@export var SPEED = 300
@onready var visible_notifier = $VisibleOnScreenNotifier2D
@onready var perry_space : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():

	perry_space = get_parent().get_parent()
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
		AudioManager.play_sound("perry_space_enemy_hit")
		area.take_damage()
		queue_free()


	pass # Replace with function body.
