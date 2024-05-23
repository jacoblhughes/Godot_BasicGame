extends Node2D

@export var enemy_scene : PackedScene

@onready var spawn_positions = $SpawnLocations
signal enemy_spawned(enemy_instance)


@export var enemy_timer : Timer

func _ready():

	enemy_timer.timeout.connect(_on_enemy_timer_timeout)
	pass # Replace with function body.

func _on_enemy_timer_timeout():
	_spawn_enemy()
	pass # Replace with function body.

func _spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()

	var enemy_instance = enemy_scene.instantiate()

	enemy_instance.global_position = random_spawn_position.position
	enemy_spawned.emit(enemy_instance)
	enemy_instance.add_to_group("enemies")

	add_child(enemy_instance,true)
