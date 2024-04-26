extends Node2D

@export var enemy_spawn_left : Marker2D
@export var enemy_spawn_right : Marker2D
@export var enemy_scene : PackedScene
@export var enemy_timer : Timer

signal enemy_squashed
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_timer.start()
	enemy_timer.timeout.connect(_on_enemy_timer_timeout)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var left_or_right_val = randi_range(0,1)
	if left_or_right_val > 0:
		enemy.position = enemy_spawn_right.position
		enemy.direction = -1
	else:
		enemy.position = enemy_spawn_left.position
		enemy.direction = 1
	enemy.enemy_squashed.connect(_on_enemy_squashed)
	add_child(enemy)

func _on_enemy_squashed():
	enemy_squashed.emit()
