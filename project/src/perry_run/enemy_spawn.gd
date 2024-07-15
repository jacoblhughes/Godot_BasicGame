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
var object_speed = 5
var xatio


var base_floor_timer_time : Array
var base_platform_timer_time : Array
var base_high_floor_timer_time : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().game_start.connect(_on_game_start)
	var floor_start_instance = floor_start.instantiate()
	floor_start_instance.position = %FloorStartPosition.position
	floor_start_instance.speed = object_speed * 20
	add_child.call_deferred(floor_start_instance)

	pass

func _on_game_start():
	floor_timer.timeout.connect(_on_floor_timer_timeout)
	platform_timer.timeout.connect(_on_platform_timer_timeout)
	#coin_timer.timeout.connect(_on_coin_timer_timeout)
	high_platform_timer.timeout.connect(_on_high_platform_timer_timeout)
	
	%FloorTimer.start()
	%PlatformTimer.start()
	%HighPlatformTimer.start()
	%CoinTimer.start()

	var floor_base_instance = floor_base.instantiate()
	floor_base_instance.position = %FloorPosition.position
	floor_base_instance.speed = object_speed
	add_child.call_deferred(floor_base_instance)


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_floor_timer_timeout():
	print('floor')
	var floor_base_instance = floor_base.instantiate()
	floor_base_instance.position = %FloorPosition.position
	floor_base_instance.speed = object_speed
	add_child.call_deferred(floor_base_instance)
	print(base_floor_timer_time)
	var new_timeout = round(randf_range(base_floor_timer_time[0],base_floor_timer_time[1]))
	%FloorTimer.wait_time = new_timeout
	%FloorTimer.start()
	pass

func _on_platform_timer_timeout():
	var platform_instance = platform_base.instantiate()
	platform_instance.position = %PlatformPosition.position
	platform_instance.speed = object_speed
	add_child.call_deferred(platform_instance)
	var new_timeout = (randf_range(base_platform_timer_time[0],base_platform_timer_time[1]))
	%PlatformTimer.wait_time = new_timeout
	%PlatformTimer.start()
	pass


func _on_high_platform_timer_timeout():
	var high_platform_instance = high_platform_base.instantiate()
	high_platform_instance.position = %HighPlatformPosition.position
	high_platform_instance.speed = object_speed

	add_child.call_deferred(high_platform_instance)
	var new_timeout = (randf_range(base_high_floor_timer_time[0],base_high_floor_timer_time[1]))
	%HighPlatformTimer.wait_time = new_timeout
	%HighPlatformTimer.start()
	pass

#func _on_coin_timer_timeout():
	#var new_location = randi_range(0,2)
	#var coin_scene_instance = coin_scene.instantiate()
	#if new_location == 0:
		#coin_scene_instance.position = %TopPosition.position
	#elif new_location == 1:
		#coin_scene_instance.position = %BottomPosition.position
	#else:
		#coin_scene_instance.position = %HighPosition.position
	#coin_scene_instance.speed = object_speed
	#add_child.call_deferred(coin_scene_instance)

func set_xatio(val):
	xatio = val

func set_object_speed(val):
	object_speed = val
	
func set_new_times(base_floor_timer_time_new,base_platform_timer_time_new,base_high_floor_timer_time_new):
	base_floor_timer_time = base_floor_timer_time_new
	base_platform_timer_time = base_platform_timer_time_new
	base_high_floor_timer_time =base_high_floor_timer_time_new
