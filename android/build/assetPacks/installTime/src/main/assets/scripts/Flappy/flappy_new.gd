extends Node2D

var score_value = 1
@onready var SpawnTimer : Timer = get_parent().get_node("SpawnTimer")
@onready var player : CharacterBody2D
@onready var start_position_marker : Marker2D
@onready var start_position = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	_game_initialize()
	player.flappy_hit.connect(_on_flappy_hit)
	start_position_marker = get_parent().get_node('StartPosition')
	start_position = start_position_marker.position
	player.position = start_position
	pass # Replace with function body.

func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	player.position = start_position
	SpawnTimer.start()
	pass


func _on_enemy_scoring_body_entered(body):

	GameManager.update_score(score_value)
	pass # Replace with function body.

func _on_flappy_hit():
	GameManager.set_game_enabled(false)
	GameManager.game_over_panel.visible = true
	SpawnTimer.stop()
	player.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	player.position = start_position
	GameManager.check_highscore_and_rank("flappy")
