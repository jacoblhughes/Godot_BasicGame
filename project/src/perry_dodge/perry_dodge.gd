extends Node2D

var initial_score_value = 0
#var score_advance_value = 1
var initial_lives_value = 1
#var lives_advance_value = 1
var initial_level_value = 1
var level_advance_check_value = 10
var level_advance_value = 1
var start_button_callable

@export var mob_scene: PackedScene
var score_value = 1

var original_mob_time = 1



# Called when the node enters the scene tree for the first time.
func _ready():
	%MobTimer.wait_time = original_mob_time
	var start_button_callable = Callable(self, "_on_play_button_pressed")
	var game_over_callable = Callable(self,"_on_game_over")
	var countdown_timer_callable = Callable(self,"_on_countdown_timer_timeout")
	HUD.hud_initialize(initial_score_value, initial_lives_value, initial_level_value,level_advance_check_value,level_advance_value,countdown_timer_callable)
	GameStartGameOver.game_start_game_over_initialize(start_button_callable,game_over_callable)
	
func _on_score_timer_timeout():
	HUD.update_score(score_value)
	if HUD.check_advance_level():
		advance_level()
	pass # Replace with function body.
	
func advance_level():
	%MobTimer.wait_time = original_mob_time * pow(.95,HUD.get_game_level())

func _on_start_timer_timeout():
	%MobTimer.start()
	%ScoreTimer.start()
	%StartTimer.stop()

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

func _on_game_over():
	GameManager.set_game_enabled(false)
	GameStartGameOver.set_gameover_panel(true)
	%MobTimer.stop()
	%ScoreTimer.stop()
	GameManager.check_highscore_and_rank()

func _on_play_button_pressed():

	GameManager.set_game_enabled(true)
	%StartTimer.start()
	pass
