extends Node3D

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3

var active_ball

var skeeballs
# Called when the node enters the scene tree for the first time.
func _ready():

	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.hide()

	#3D

	%Shelf.load_ball.connect(_on_load_ball)
	%ScoreTarget.scored.connect(_on_scored)

	skeeballs = get_tree().get_nodes_in_group("skeeballs")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

#	if Input.is_action_just_pressed("hit_space"):
#		if %Camera1.current==true:
#			%Camera1.current=false
#			%Camera2.current==true
#		else:
#			%Camera1.current=true
#			%Camera2.current=false
	pass

func _on_load_ball(event,input_position):
	if event is InputEventScreenTouch and event.pressed and active_ball == null:
		set_up_new_ball()

func set_up_new_ball():

	skeeballs = get_tree().get_nodes_in_group("skeeballs")
	if len(skeeballs)>0:
		active_ball = skeeballs[0]
		active_ball.remove_ball.connect(_on_dead_ball)

		active_ball.get_ready(%StartingPoint.global_position)

	pass


func _on_ball_despawn_body_entered(body):
	if body is PerrySkeeball:
		body.dead_ball()
	pass # Replace with function body.


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventScreenTouch and event.pressed and active_ball != null:
		active_ball.shoot()
	pass # Replace with function body.

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_game_over():
	pass

func _on_scored():
	HUD.update_score()

func _on_dead_ball():
	active_ball = null
	skeeballs = get_tree().get_nodes_in_group("skeeballs")

	if len(skeeballs) <= 1:
		HUD.update_lives()
