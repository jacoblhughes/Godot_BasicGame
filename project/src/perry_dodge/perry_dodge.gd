extends Node2D

var initial_score_value = 0
var score_advance_base_value = 1
var initial_lives_value = 1
var lives_advance_base_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_base_value = 1
var start_timer_countdown_value = 3
var game_time_left_timer_value = 3

@export var mob_scene: PackedScene

var original_mob_time = 1

# Called when the node enters the scene tree for the first time.
func _ready():

	
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

#	if yform > 1280:
#		%Camera2D.enabled = true
#		%Camera2D.zoom.y = yform/1280

	if xform > 720:

		var nodes_to_move =[%StartPosition]
		for node in nodes_to_move:
			node.position.x *= xatio
		var nodes_to_scale = [%TileMap]
		for node in nodes_to_scale:
			node.scale.x *= xatio
	
	%Player.start(%StartPosition.position)
	%ScoreAndMobTimer.wait_time = original_mob_time
	%ScoreAndMobTimer.timeout.connect(_on_mob_timer_timeout)
	
func advance_level():
	%ScoreAndMobTimer.wait_time = original_mob_time * pow(.95,HUD.return_game_level())

func _on_mob_timer_timeout():

	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = %MobPathFollow
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var sprite = mob.get_node("AnimatedSprite2D")
	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	sprite.rotation = velocity.angle() + PI/2
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	get_parent().add_child(mob)

	HUD.update_score()
	if HUD.check_advance_level():
		advance_level()


func _on_game_over():
	%ScoreAndMobTimer.stop()

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	%ScoreAndMobTimer.start()
	pass
