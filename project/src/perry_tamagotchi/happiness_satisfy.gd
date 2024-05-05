extends Node2D

signal happiness_satisfy_animation_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	%AnimatedSprite2D.animation_finished.connect(_on_animation_finished)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_playing_animation():
	%Sprite2D.hide()
	%AnimatedSprite2D.play("default")

	pass

func _on_animation_finished():
	happiness_satisfy_animation_finished.emit()
	%AnimatedSprite2D.stop()
	%Sprite2D.show()
	pass
