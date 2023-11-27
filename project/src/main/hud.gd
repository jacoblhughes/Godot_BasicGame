extends Control

# Export the NodePath to the player_initials scene

signal hud_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	hud_ready.emit()
	pass
