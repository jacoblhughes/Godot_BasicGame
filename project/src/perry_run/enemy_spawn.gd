extends Node2D

@export var enemy_timer : Timer
@export var enemy_floor : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	
	enemy_timer.timeout.connect(_on_enemy_timer_timeout)
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
