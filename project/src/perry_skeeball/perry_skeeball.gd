extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Background.visible = false
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%Skeeball.global_position = lerp(%Skeeball.global_position,%StartingArea.return_start_position(),delta * .1)
	pass
