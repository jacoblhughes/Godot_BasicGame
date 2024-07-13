extends Node2D

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 3
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 1

@export var starting_marker : Marker2D
@export var pinball_scene : PackedScene

@export var nodes_to_move_x : Array[Node]
@export var nodes_to_scale_x : Array[Node]
@export var nodes_to_move_y : Array[Node]
@export var nodes_to_scale_y : Array[Node]

var xform = 0
var yform = 0
var xatio = 0
var yatio = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	var advance_level_callable = Callable(self,"_on_advance_level")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value,advance_level_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)


	var xform = get_viewport_rect().size.x
	var yform = get_viewport_rect().size.y
	var xatio = xform/720
	var yatio = yform/1280
	print(xform , " " , yform)

	if yform > 1280:
		for node in nodes_to_move_y:
			node.position.y *= yatio
		for node in nodes_to_scale_y:
			node.scale.y *= yatio

	if xform > 720:
		for node in nodes_to_move_x:
			node.position.x *= xatio
		for node in nodes_to_scale_x:
			node.scale.x *= xatio


	_spawn_pinball()
	%Fall.pinball_oob.connect(_on_pinball_ooo)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _spawn_pinball():
	var pinball = pinball_scene.instantiate()
	pinball.position = starting_marker.position
	pinball.scale = Vector2(xatio,yatio)

	add_child.call_deferred(pinball)
	pass

func _on_pinball_ooo():
	_spawn_pinball()
