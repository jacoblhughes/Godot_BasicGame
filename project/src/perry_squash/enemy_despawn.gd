extends Node2D

@export var enemy_despawn_left : Area2D
@export var enemy_despawn_right : Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_despawn_left.body_entered.connect(_on_body_entered)
	enemy_despawn_right.body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is PerrySquashEnemy:
		body.die()
