extends Node2D

@onready var enemy_wall = preload("res://scenes/Flappy/enemy_wall.tscn")
@onready var enemy_wall_2 = preload("res://scenes/Flappy/enemy_wall_2.tscn")
@onready var enemy_wall_3  = preload("res://scenes/Flappy/enemy_wall_3.tscn")
var scenes

# Called when the node enters the scene tree for the first time.
func _ready():

	scenes = [enemy_wall, enemy_wall_2, enemy_wall_3]

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
