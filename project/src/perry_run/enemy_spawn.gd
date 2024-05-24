extends Node2D

@export var floor_timer : Timer
@export var platform_timer : Timer
@export var high_platform_timer : Timer
@export var coin_timer : Timer
@export var floor_base : PackedScene
@export var floor_start : PackedScene
@export var platform_base : PackedScene
@export var high_platform_base : PackedScene
@export var coin_scene : PackedScene
var object_speed = 0
var xatio

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().game_start.connect(_on_game_start)
	pass

func _on_game_start():
	floor_timer.timeout.connect(_on_floor_timer_timeout)
	platform_timer.timeout.connect(_on_platform_timer_timeout)
	coin_timer.timeout.connect(_on_coin_timer_timeout)
	high_platform_timer.timeout.connect(_on_high_platform_timer_timeout)
	var floor_start_instance = floor_start.instantiate()
	floor_start_instance.position = %FloorStartPosition.position
	floor_start_instance.speed = object_speed
	add_child.call_deferred(floor_start_instance)
	await get_tree().create_timer(4/xatio).timeout

	var floor_base_instance = floor_base.instantiate()
	floor_base_instance.position = %FloorPosition.position
	floor_base_instance.speed = object_speed
	add_child.call_deferred(floor_base_instance)

	%FloorTimer.start()
	%PlatformTimer.start()
	%HighPlatformTimer.start()
	%CoinTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_floor_timer_timeout():
	var floor_base_instance = floor_base.instantiate()
	floor_base_instance.position = %FloorPosition.position
	floor_base_instance.speed = object_speed
	add_child.call_deferred(floor_base_instance)
	var new_timeout = round(randf_range(1,2)*2)/2
	%FloorTimer.wait_time = new_timeout
	pass

func _on_platform_timer_timeout():
	var platform_instance = platform_base.instantiate()
	platform_instance.position = %PlatformPosition.position
	platform_instance.speed = object_speed
	add_child.call_deferred(platform_instance)
	var new_timeout = round(randf_range(2,6)*2)/2
	%PlatformTimer.wait_time = new_timeout
	pass


func _on_high_platform_timer_timeout():
	var high_platform_instance = high_platform_base.instantiate()
	high_platform_instance.position = %HighPlatformPosition.position
	high_platform_instance.speed = object_speed

	add_child.call_deferred(high_platform_instance)
	var new_timeout = round(randf_range(2,6)*2)/2
	%HighPlatformTimer.wait_time = new_timeout
	pass

func _on_coin_timer_timeout():
	var new_location = randi_range(0,2)
	var coin_scene_instance = coin_scene.instantiate()
	if new_location == 0:
		coin_scene_instance.position = %TopPosition.position
	elif new_location == 1:
		coin_scene_instance.position = %BottomPosition.position
	else:
		coin_scene_instance.position = %HighPosition.position
	coin_scene_instance.speed = object_speed
	add_child.call_deferred(coin_scene_instance)

func set_xatio(val):
	xatio = val

func set_object_speed(val):
	object_speed = val
