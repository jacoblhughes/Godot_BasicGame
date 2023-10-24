extends Node2D

@onready var enemy_scene  = preload("res://scenes/Dino/enemy.tscn")

var enemy_counter = 1


# Called when the node enters the scene tree for the first time.
func _ready():
#	GameManager.resetButtonPressed.connect(on_reset_button_reset_button_pressed)

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	pass
	
	


func _on_enemy_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.name = "Enemy" + str(enemy_counter)
	enemy_counter+=1
	get_parent().add_child.call_deferred(enemy)
	pass # Replace with function body.


func _on_despawn_body_entered(body):

	if("Enemy" in body.name):
		body.queue_free()
		GameManager.set_new_score(1)
	pass # Replace with function body.
