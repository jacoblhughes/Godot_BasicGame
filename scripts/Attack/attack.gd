extends Node2D

@onready var Player : CharacterBody2D
@onready var StartPosition : Marker2D
@onready var EnemyHitSound : AudioStreamPlayer = get_parent().get_node("EnemyHitSound")
@onready var PlayerDamageSound : AudioStreamPlayer = get_parent().get_node("PlayerDamageSound")
@onready var LiveLeftLabel :Label = get_parent().get_node("LivesLeft")
var lives = 3
var score = 0
# Called when the node enters the scene tree for the first time.
var screen_size = HUDVariables.get_play_area_size_from_HUD()
var screen_position = HUDVariables.get_play_area_position_from_HUD()


func _ready():
	LiveLeftLabel.text = str(lives)
	Player = get_parent().get_node("Player")
	StartPosition = get_parent().get_node("StartPosition")
	Player.start(StartPosition.position)
	Player.connect("took_damage",_on_player_take_damage)
#	Player.connect("took_damage",_on_player_take_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_take_damage():
	lives -=1
	LiveLeftLabel.text = str(lives)
	PlayerDamageSound.play()

func _on_deathzone_area_entered(area):
	area.die()
	pass # Replace with function body.


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died",_on_enemy_died)
	pass # Replace with function body.

func _on_enemy_died():
	EnemyHitSound.play()
	score += 1



func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):

	path_enemy_instance.enemy.connect("died",_on_path_enemy_died)
	pass # Replace with function body.
	
func _on_path_enemy_died():
	EnemyHitSound.play()
	score += 1
