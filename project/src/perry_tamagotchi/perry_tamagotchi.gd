extends Node2D

@export var status_hud : CanvasLayer
@export var player_scene : PackedScene
@export var egg_scene : PackedScene
@export var starting_marker : Marker2D

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

var last_check = Time.get_unix_time_from_system()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Time.get_unix_time_from_system())
	print(Time.get_datetime_dict_from_system())


	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var start_timer_countdown_callable = Callable(self,"_on_start_timer_countdown_timeout")
	var game_time_left_timer_callable = Callable(self,"_on_game_time_left_timer_timeout")
	HUD.hud_initialize(initial_score_value,score_advance_base_value, initial_lives_value,lives_advance_base_value, initial_level_value,level_advance_check_value,level_advance_base_value,start_timer_countdown_callable,start_timer_countdown_value, game_time_left_timer_callable,game_time_left_timer_value)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	Background.show()

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
	hatch_time = tamagotchi_status.get("hatch_time", null)
	health_status = tamagotchi_status.get("health", 100)
	hunger_status = tamagotchi_status.get("hunger", 100)
	happiness_status = tamagotchi_status.get("happiness", 100)

	# Print statements to verify the values
	print("Living Status: " + str(living_status))
	print("Hatch Time: " + str(hatch_time))
	print("Health Status: " + str(health_status))
	print("Hunger Status: " + str(hunger_status))
	print("Happiness Status: " + str(happiness_status))



	status_hud.set_status({
		"living": living_status,
		"hatch_time": hatch_time,
		"health": health_status,
		"hunger": hunger_status,
		"happiness": happiness_status
	})

	if living_status:
		var player = player_scene.instantiate()
		player.position = starting_marker.position
		add_child.call_deferred(player)
	else:
		var egg = egg_scene.instantiate()
		egg.position = starting_marker.position
		egg.egg_hatched.connect(_on_egg_hatched)
		add_child.call_deferred(egg)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_time = Time.get_unix_time_from_system()
	if current_time - last_check > 5:
		last_check = Time.get_unix_time_from_system()
		print("hungry")
		status_hud.set_status({
			"living": living_status,
			"hatch_time": hatch_time,
			"health": health_status,
			"hunger": hunger_status,
			"happiness": happiness_status
		})


	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)

func _on_egg_hatched():
	var player = player_scene.instantiate()
	player.position = starting_marker.position
	living_status = true
	hatch_time = Time.get_datetime_string_from_system()
	add_child.call_deferred(player)
	status_hud.set_status({
		"living": living_status,
		"hatch_time": hatch_time,
		"health": health_status,
		"hunger": hunger_status,
		"happiness": happiness_status
	})
	GameManager.save_perry_tamagotchi_status({
		"living": living_status,
		"hatch_time": hatch_time,
		"health": health_status,
		"hunger": hunger_status,
		"happiness": happiness_status
	})
	pass
