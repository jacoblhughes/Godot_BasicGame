extends Node2D

@export var status_hud : CanvasLayer
@export var player_scene : PackedScene
@export var egg_scene : PackedScene
@export var starting_marker : Marker2D
@export var tween_locations_node : Node2D
@export var hunger_satisfy_node : Node2D
@export var happiness_satisfy_node : Node2D

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3

var living_status
var hatch_time
var health_status
var hunger_status
var happiness_status
var last_hunger_satisfy
var last_health_satisfy
var last_happiness_satisfy

var base_penalize_seconds = 1728
var hunger_penalize_seconds = base_penalize_seconds
var happiness_penalize_decrease = base_penalize_seconds*2
var health_penalize_decrease = base_penalize_seconds
var health_effected = false

signal player_to_eat
signal player_to_play

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
		var nodes_to_move = []
		for node in nodes_to_move:
			node.position.y *= yatio
		var nodes_to_scale = []
		for node in nodes_to_scale:
			node.scale.y *= yatio

	if xform > 720:
		var nodes_to_move = []
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = []



	# Load the status from the GameManager
	var tamagotchi_status = GameManager.load_perry_tamagotchi_status()

	# Assign the loaded values to the variables
	living_status = tamagotchi_status.get("living", false)
	hatch_time = tamagotchi_status.get("hatch_time",  {})
	health_status = tamagotchi_status.get("health", 100)
	hunger_status = tamagotchi_status.get("hunger", 100)
	happiness_status = tamagotchi_status.get("happiness", 100)
	last_hunger_satisfy = tamagotchi_status.get("last_hunger_satisfy",  {})
	last_health_satisfy = tamagotchi_status.get("last_health_satisfy",  {})
	last_happiness_satisfy =  tamagotchi_status.get("last_happiness_satisfy",  {})

	if !living_status or hatch_time == {} or last_hunger_satisfy == {} or last_health_satisfy == {} or last_happiness_satisfy == {}:
		living_status = false
		health_status = 100
		hunger_status = 100
		happiness_status = 100
		last_hunger_satisfy = {}
		last_health_satisfy = {}
		last_happiness_satisfy= {}
		hatch_time = {}
	else:
		var current_time = Time.get_unix_time_from_system()
		var days_since_hatch = int((current_time - Time.get_unix_time_from_datetime_dict(hatch_time)) / 86400)
		var seconds_since_last_hunger_satisfy = current_time - Time.get_unix_time_from_datetime_dict(last_hunger_satisfy)
		var hunger_decrease = floor(seconds_since_last_hunger_satisfy / hunger_penalize_seconds)
		var seconds_since_last_happiness_satisfy = current_time - Time.get_unix_time_from_datetime_dict(last_happiness_satisfy)
		var happiness_decrease = floor(seconds_since_last_happiness_satisfy / happiness_penalize_decrease)

		if hunger_decrease > 0:
			hunger_status = max(hunger_status - hunger_decrease, 0)  # Reduce hunger, prevent it from going below 0
			last_hunger_satisfy = Time.get_datetime_dict_from_unix_time(current_time)

		if happiness_decrease > 0:
			happiness_status = max(happiness_status - happiness_decrease, 0)  # Reduce hunger, prevent it from going below 0
			last_happiness_satisfy = Time.get_datetime_dict_from_unix_time(current_time)

		if hunger_status == 0 or happiness_status == 0:
			health_effected = true

		if health_effected:
			var seconds_since_last_health_satisfy = current_time - Time.get_unix_time_from_datetime_dict(last_health_satisfy)
			var health_decrease = floor(seconds_since_last_health_satisfy / health_penalize_decrease)
			if health_decrease > 0:
				health_status = max(health_status - health_decrease, 0)
				last_health_satisfy = Time.get_datetime_dict_from_unix_time(current_time)

		_update_score(days_since_hatch)

	_update_status_and_save()

	status_hud.hunger_satisfy.connect(_on_hunger_satisfy_button_pressed)
	status_hud.happiness_satisfy.connect(_on_happiness_satisfy_button_pressed)

	if living_status:
		_initiate_player()
	else:
		var egg = egg_scene.instantiate()
		egg.position = starting_marker.position
		egg.egg_hatched.connect(_on_egg_hatched)
		add_child.call_deferred(egg)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if living_status and last_hunger_satisfy != {} and last_happiness_satisfy != {} and GameManager.get_game_enabled():
		_check_hunger_and_happiness()
	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_game_over():
	GameManager.set_game_enabled(true)
	living_status = false
	health_status = 100
	hunger_status = 100
	happiness_status = 100
	last_hunger_satisfy = {}
	last_health_satisfy = {}
	last_happiness_satisfy= {}
	hatch_time = {}


	_update_status_and_save()


func _on_egg_hatched():

	living_status = true
	var current_time = Time.get_unix_time_from_system()
	hatch_time = Time.get_datetime_dict_from_unix_time(current_time)
	last_hunger_satisfy = Time.get_datetime_dict_from_unix_time(current_time)
	last_health_satisfy = Time.get_datetime_dict_from_unix_time(current_time)
	last_happiness_satisfy = Time.get_datetime_dict_from_unix_time(current_time)
	_initiate_player()
	_update_status_and_save()


	pass

func _check_hunger_and_happiness():

	var current_time = Time.get_unix_time_from_system()
	var days_since_hatch = int((current_time - Time.get_unix_time_from_datetime_dict(hatch_time)) / 86400) + 1
	var seconds_since_last_hunger_satisfy = current_time - Time.get_unix_time_from_datetime_dict(last_hunger_satisfy)
	var hunger_decrease = floor(seconds_since_last_hunger_satisfy / hunger_penalize_seconds)  # Calculate how much hunger should decrease
	var seconds_since_last_happiness_satisfy = current_time - Time.get_unix_time_from_datetime_dict(last_happiness_satisfy)
	var happiness_decrease = floor(seconds_since_last_happiness_satisfy / happiness_penalize_decrease)
	if !health_effected:
		last_health_satisfy = Time.get_datetime_dict_from_unix_time(current_time)
	var seconds_since_last_health_satisfy = current_time - Time.get_unix_time_from_datetime_dict(last_health_satisfy)
	var health_decrease = floor(seconds_since_last_health_satisfy / health_penalize_decrease)



	if hunger_decrease > 0:
		hunger_status = max(hunger_status - hunger_decrease, 0)  # Reduce hunger, prevent it from going below 0
		last_hunger_satisfy = Time.get_datetime_dict_from_unix_time(current_time)  # Reset last satisfy time
		_update_status_and_save()
		_update_score(days_since_hatch)
		if hunger_status == 0:
			health_effected = true

	if happiness_decrease > 0:
		happiness_status = max(happiness_status - happiness_decrease, 0)  # Reduce hunger, prevent it from going below 0
		last_happiness_satisfy = Time.get_datetime_dict_from_unix_time(current_time)  # Reset last satisfy time
		_update_status_and_save()
		_update_score(days_since_hatch)
		if happiness_status == 0:
			health_effected = true
#

	if health_effected and health_decrease > 0:
		health_status = max(health_status - health_decrease, 0)
		last_health_satisfy = Time.get_datetime_dict_from_unix_time(current_time)  # Reset last satisfy time
		_update_status_and_save()
		_update_score(days_since_hatch)
		if health_status <= 0:
			HUD.update_lives()


	if hunger_status > 0 and happiness_status > 0 and health_status < 100:

			health_effected = false
			health_status +=1 # Subtract some health if hunger reaches 0
			health_status = min(health_status, 100)  # Prevent health from dropping below 0
			_update_status_and_save()
		## Update the HUD and save the game state

	if health_status <=0:
		HUD.update_lives()

func _update_status_and_save():

	status_hud.set_status({
		"living": living_status,
		"hatch_time": hatch_time,
		"health": health_status,
		"hunger": hunger_status,
		"happiness": happiness_status,
		"last_hunger_satisfy": last_hunger_satisfy,
		"last_health_satisfy": last_health_satisfy,
		"last_happiness_satisfy": last_happiness_satisfy
	})
	GameManager.save_perry_tamagotchi_status({
		"living": living_status,
		"hatch_time": hatch_time,
		"health": health_status,
		"hunger": hunger_status,
		"happiness": happiness_status,
		"last_hunger_satisfy": last_hunger_satisfy,
		"last_health_satisfy": last_health_satisfy,
		"last_happiness_satisfy": last_happiness_satisfy
	})

func _update_score(value):
	HUD.set_or_reset_score(value)


func _initiate_player():
	status_hud.show()
	var player = player_scene.instantiate()
	player.position = starting_marker.position

	player_to_eat.connect(Callable(player, "_on_player_to_eat"))
	player.player_eating.connect(Callable(hunger_satisfy_node, "play_eating_animation"))
	hunger_satisfy_node.hunger_satisfy_animation_finished.connect(Callable(player, "_on_player_finished_eating"))
	player.player_finished_eating.connect(Callable(status_hud,"_on_player_finished_eating"))
	player.player_finished_eating.connect(_on_player_hunger_satisfy)

	player_to_play.connect(Callable(player, "_on_player_to_play"))
	player.player_playing.connect(Callable(happiness_satisfy_node, "play_playing_animation"))
	happiness_satisfy_node.happiness_satisfy_animation_finished.connect(Callable(player, "_on_player_finished_playing"))
	player.player_finished_playing.connect(Callable(status_hud,"_on_player_finished_playing"))
	player.player_finished_playing.connect(_on_player_happiness_satisfy)


	var location_markers = []
	location_markers.append(starting_marker.position)
	for node in tween_locations_node.get_children():
		location_markers.append(node.position)

	add_child.call_deferred(player)
	player.call_deferred("assign_tween_positions",location_markers)
	player.call_deferred("assign_hunger_satisfy_position",hunger_satisfy_node.position)
	player.call_deferred("assign_happiness_satisfy_position",happiness_satisfy_node.position)


func _on_hunger_satisfy_button_pressed():
	player_to_eat.emit()
	pass

func _on_player_hunger_satisfy():
	var current_time = Time.get_unix_time_from_system()
	last_hunger_satisfy = Time.get_datetime_dict_from_unix_time(current_time)
	hunger_status = min(hunger_status + 20, 100)
	_update_status_and_save()

func _on_happiness_satisfy_button_pressed():
	player_to_play.emit()
	pass

func _on_player_happiness_satisfy():
	var current_time = Time.get_unix_time_from_system()
	last_happiness_satisfy = Time.get_datetime_dict_from_unix_time(current_time)
	happiness_status = min(happiness_status + 20, 100)
	_update_status_and_save()

func _on_advance_level():
	pass
