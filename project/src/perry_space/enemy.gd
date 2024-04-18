extends Area2D
class_name SpaceEnemy

@export var SPEED = 120

var health

@onready var enemy_die_sound : AudioStreamPlayer = $EnemyHitSound
# Called when the node enters the scene tree for the first time.
func _ready():
	var value = floor(randf_range(1,4))
	scale *= value
	health = value
	var skin = floor(randf_range(1,4))
	if skin == 1:
		%AnimatedSprite2D.play("blue")
	elif skin == 2:
		%AnimatedSprite2D.play("yellow")
	else:
		%AnimatedSprite2D.play("green")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x -= SPEED * delta
	pass

func die():

	queue_free()

func _on_body_entered(body):
	if body is PerrySpacePlayer:
		body.take_damage()
		die()
	pass # Replace with function body.

func take_damage():
	var old_health = health
	var new_health = old_health - 1
	health = new_health
	if health <= 0:
		die()
