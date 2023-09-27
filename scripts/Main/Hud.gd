extends CanvasLayer

# Export the NodePath to the player_initials scene
@onready var player_initials = PlayerInitials.get_initials()
@onready var InitialsInput : Label

# Called when the node enters the scene tree for the first time.
func _ready():	
	InitialsInput = $Control/Initials
	update_initials_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	player_initials = PlayerInitials.get_initials()
	InitialsInput.text = player_initials

func update_initials_label():

	if player_initials:
		InitialsInput.text = player_initials
	else:
		print("Player initials instance not found or does not have the 'get_initials' function.")


func _on_home_button_pressed():
	
	pass # Replace with function body.
