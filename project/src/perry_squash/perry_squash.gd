extends Node3D

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
	HUD.reset_score()
	HUD.startButtonPressed.connect(_on_play_button_pressed)
	HUD.set_or_reset_level(1)
	HUD.countdown_timer_timeout.connect(_on_countdown_timer_timeout)

func _physics_process(delta):
	if GameManager.get_game_enabled():
		spotlight.position.x  = player.position.x
		spotlight.position.z = player.position.z
		
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_parent().get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	var player_position = player.position
	mob.initialize(mob_spawn_location.position, player_position)
	mob.squashed.connect(_on_mob_squashed)
	get_parent().add_child(mob)

func _on_player_hit():
	if GameManager.get_game_enabled():
		for node in get_tree().get_nodes_in_group("enemy"):
			node.velocity= Vector3.ZERO
		mob_timer.stop()
		GameManager.set_game_enabled(false)
		HUD.set_gameover_panel(true)
		GameManager.check_highscore_and_rank()
		player.allow_move(false)

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	HUD.countdown_timer_start_and_time_left()

func _on_countdown_timer_timeout():
	player.allow_move(true)
	mob_timer.start()

func _on_mob_squashed():
	HUD.update_score(score_value)

