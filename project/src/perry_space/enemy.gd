extends Area2D
class_name SpaceEnemy

@export var SPEED = 120

@onready var enemy_die_sound : AudioStreamPlayer = $EnemyHitSound
signal died
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x -= SPEED * delta
	pass

func die():
#	SPEED = 0
#	$CollisionShape2D.disabled=true
#	enemy_die_sound.play()
	died.emit()
#	await get_tree().create_timer(1).timeout
	queue_free()



func _on_body_entered(body):
	body.take_damage()
	die()
	pass # Replace with function body.
