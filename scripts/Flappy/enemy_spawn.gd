extends Node2D

@onready var EnemyWall = preload("res://scenes/Flappy/EnemyWall.tscn")
@onready var EnemyWall2 = preload("res://scenes/Flappy/EnemyWall2.tscn")
@onready var EnemyWall3  = preload("res://scenes/Flappy/EnemyWall3.tscn")
var scenes

# Called when the node enters the scene tree for the first time.
func _ready():

	scenes = [EnemyWall, EnemyWall2, EnemyWall3]

	# Choose a scene randomly

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	pass

func _on_spawn_timer_timeout():
	var chosen = randi() % scenes.size()
	print(chosen)
	# Load and switch to the chosen scene
	print(scenes[chosen])
	var chosen_scene = scenes[chosen] 
	print(chosen_scene)
	get_parent().add_child(chosen_scene.instantiate())
	pass # Replace with function body.
