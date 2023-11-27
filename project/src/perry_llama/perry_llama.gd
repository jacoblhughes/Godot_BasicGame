extends Node2D

@onready var enemy_scene  = preload("res://src/perry_llama/enemy.tscn")
@onready var player : CharacterBody2D
@onready var enemy_spawn_timer : Timer
var score_value = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_spawn_timer = get_parent().get_node("Enemy_Spawn_Timer")
	player = get_parent().get_node("Player")
	_game_initialize()
	player.dino_hit.connect(_on_dino_hit)
	pass # Replace with function body.

func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)



func _physics_process(delta):

	pass
	
func _on_enemy_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	get_parent().add_child.call_deferred(enemy,true)
	pass # Replace with function body.


func _on_despawn_body_entered(body):

	if("Enemy" in body.name):
		body.queue_free()
		GameManager.update_score(score_value)
	pass # Replace with function body.

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
	enemy_spawn_timer.start()

func _on_dino_hit():
	enemy_spawn_timer.stop()
	GameManager.set_game_enabled(false)
	GameManager.set_gameover_panel(true)
	GameManager.check_highscore_and_rank()


func _on_floor_input_event(viewport, event, shape_idx):

	pass # Replace with function body.
