extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%Button.pressed.connect(_on_home_button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_home_button_pressed():
	HUD.home_button_pressed()
