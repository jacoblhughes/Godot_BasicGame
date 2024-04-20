extends Node2D

@export var enemy_timer : Timer
@export var enemy_floor : PackedScene
@export var enemy_start : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().game_start.connect(_on_game_start)
	pass

func _on_game_start():
	enemy_timer.timeout.connect(_on_enemy_timer_timeout)
	var enemy_start_instance = enemy_start.instantiate()
	enemy_start_instance.position = %EnemyPositionStart.position
	add_child.call_deferred(enemy_start_instance)
	await get_tree().create_timer(6).timeout
	var enemy_floor_instance = enemy_floor.instantiate()
	enemy_floor_instance.position = %EnemyPositionFloor.position
	add_child.call_deferred(enemy_floor_instance)
	%EnemyTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_timer_timeout():
	print('here')
	var enemy_floor_instance = enemy_floor.instantiate()
	enemy_floor_instance.position = %EnemyPositionFloor.position
	add_child.call_deferred(enemy_floor_instance)
	pass
