extends Node2D

@export var floor_timer : Timer
@export var platform_timer : Timer
@export var floor_base : PackedScene
@export var floor_start : PackedScene
@export var platform_base : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().game_start.connect(_on_game_start)
	pass

func _on_game_start():
	floor_timer.timeout.connect(_on_floor_timer_timeout)
	platform_timer.timeout.connect(_on_platform_timer_timeout)
	print('base start')
	var floor_start_instance = floor_start.instantiate()
	floor_start_instance.position = %FloorStartPosition.position
	add_child.call_deferred(floor_start_instance)
	await get_tree().create_timer(6).timeout
	print('first base')
	var floor_base_instance = floor_base.instantiate()
	floor_base_instance.position = %FloorPosition.position
	add_child.call_deferred(floor_base_instance)
	%FloorTimer.start()
	print('start timer')
	%PlatformTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_floor_timer_timeout():
	var floor_base_instance = floor_base.instantiate()
	floor_base_instance.position = %FloorPosition.position
	add_child.call_deferred(floor_base_instance)
	var new_timeout = randi_range(2,2)
	%FloorTimer.wait_time = new_timeout
	pass

func _on_platform_timer_timeout():
	var platform_instance = platform_base.instantiate()
	platform_instance.position = %PlatformPosition.position
	add_child.call_deferred(platform_instance)
	var new_timeout = randi_range(3,5)
	%PlatformTimer.wait_time = new_timeout
	pass
