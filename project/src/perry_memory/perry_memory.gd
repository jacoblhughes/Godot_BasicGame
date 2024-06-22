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

@export var cards_node : Node2D
var current_level : int = 1

@export var nodes_to_move_x : Array[Node]
@export var nodes_to_scale_x : Array[Node]
@export var nodes_to_move_y : Array[Node]
@export var nodes_to_scale_y : Array[Node]

var xform = 0
var yform = 0
var xatio = 0
var yatio = 0

var first_card = null
var second_card = null

# Called when the node enters the scene tree for the first time.
func _ready():
	cards_node.card_selected.connect(_on_card_selected)
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	var advance_level_callable = Callable(self,"_on_advance_level")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value,advance_level_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()

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

	cards_node.create_game(current_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_card_selected(value):
	if first_card == null:
		first_card = value
		first_card.flip_card()
	elif first_card != null and second_card == null and value != first_card:
		second_card = value
		second_card.flip_card()
		if second_card.flip_card_animation_finished.is_connected(_on_second_card_animation_finished):
			second_card.flip_card_animation_finished.disconnect(_on_second_card_animation_finished)
		#if second_card.flip_back_card_animation_finished.is_connected(_on_second_back_card_animation_finished):
			#second_card.flip_back_card_animation_finished.disconnect(_on_second_back_card_animation_finished)
		second_card.flip_card_animation_finished.connect(_on_second_card_animation_finished)
		#second_card.flip_back_card_animation_finished.connect(_on_second_back_card_animation_finished)


func _on_second_card_animation_finished():
	if first_card !=null and second_card !=null:
		if first_card.selection == second_card.selection:
			first_card.remove_card()
			second_card.remove_card()
			first_card = null
			second_card = null
			HUD.update_score()
			if len(cards_node.get_children()) <= 2:
				current_level += 1
				HUD.set_or_reset_level(current_level)
				if cards_node.get_child_count() > 0:
					for node in cards_node.get_children():
						node.queue_free()

				if HUD.return_game_level() >=6:
					HUD.update_lives()
				else:
					cards_node.create_game(current_level)

		else:
			first_card.flip_card_back()
			second_card.flip_card_back()
			first_card = null
			second_card = null

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_game_over():
	pass

func _on_start_timer_countdown_timeout():
	pass

func _on_game_time_left_timer_timeout():
	pass

func _on_advance_level():
	pass
