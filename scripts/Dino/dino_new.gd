extends Node2D

@onready var enemy_scene  = preload("res://scenes/Dino/enemy.tscn")




# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.



func _physics_process(delta):

	pass
	
func _on_enemy_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	get_parent().add_child.call_deferred(enemy,true)
	pass # Replace with function body.


func _on_despawn_body_entered(body):

	if("Enemy" in body.name):
		body.queue_free()
		GameManager.set_new_score(1)
	pass # Replace with function body.
