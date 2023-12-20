extends Node

@export var mob_scene: PackedScene
@onready var player : CharacterBody3D = get_parent().get_node("Player")
@onready var mob_timer : Timer = get_parent().get_node("EnemyTimer")
@onready var spotlight : MeshInstance3D = get_parent().get_node("Spotlight")
var enemies
var score_value = 1
func _ready():
	player.hit.connect(_on_player_hit)
	mob_timer.timeout.connect(_on_mob_timer_timeout)
	_game_initialize()
	pass
	
	
func _game_initialize():
	for node in get_tree().get_nodes_in_group("enemy"):
		node.remove_from_group("enemy")
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)
	GameManager.set_or_reset_level(1)

func _physics_process(delta):
	if GameManager.get_game_enabled():
		spotlight.position.x  = player.position.x
		spotlight.position.z = player.position.z
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_parent().get_node("SpawnPath/SpawnLocation")
	# And give imob_timert a random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = player.position
	mob.initialize(mob_spawn_location.position, player_position)
	mob.squashed.connect(_on_mob_squashed)
#	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
	# Spawn the mob by adding it to the Main scene.
	get_parent().add_child(mob)


func _on_player_hit():
	if GameManager.get_game_enabled():
		for node in get_tree().get_nodes_in_group("enemy"):
			node.velocity= Vector3.ZERO
		mob_timer.stop()
		GameManager.set_game_enabled(false)
		GameManager.set_gameover_panel(true)
		GameManager.check_highscore_and_rank()
#	$UserInterface/Retry.show()
#
#func _unhandled_input(event):
#	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
#		# This restarts the current scene.
#		get_tree().reload_current_scene()

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	mob_timer.start()

func _on_mob_squashed():

	GameManager.update_score(score_value)
