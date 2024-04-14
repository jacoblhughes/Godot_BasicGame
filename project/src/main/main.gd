extends Node

signal main_ready



# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.hide()
	GameStartGameOver.hide()
	Background.hide()
	pass # Replace with function body.

			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed('pc_reset'):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("pc_quit"):
		get_tree().quit()


	pass


