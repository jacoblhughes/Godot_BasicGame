extends Node2D

@export var reverse = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if reverse:
		%Sprite2D.flip_h = true
		%AnimationPlayer.play("crawl_right")
	else:
		%AnimationPlayer.play("crawl_left")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
