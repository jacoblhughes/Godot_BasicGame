extends Node2D

@onready var enemy_scene = preload("res://scenes/Attack/enemy.tscn")
@onready var path_enemy_scene = preload("res://scenes/Attack/path_enemy.tscn")
@onready var spawn_positions = $SpawnLocations
signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_timer_timeout():
	_spawn_enemy()
	pass # Replace with function body.
	
func _spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	
	enemy_instance.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawned",enemy_instance)
	enemy_instance.add_to_group("enemies")
	add_child(enemy_instance,true)


func _on_path_enemy_timer_timeout():

#	var path_enemy_instance = path_enemy_scene.instantiate()
#	add_child(path_enemy_instance,true)
#	emit_signal("path_enemy_spawned",path_enemy_instance)

	pass # Replace with function body.
