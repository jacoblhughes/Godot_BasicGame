extends Node2D

@onready var enemy_scene  = preload("res://scenes/Dino/Enemy.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	
	var enemy = enemy_scene.instantiate()
	get_parent().add_child.call_deferred(enemy)

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	pass


func _on_enemy_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	get_parent().add_child.call_deferred(enemy)
	pass # Replace with function body.


func _on_despawn_body_entered(body):
	print(body.name)
	pass # Replace with function body.
