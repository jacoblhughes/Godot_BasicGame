extends Node2D

@onready var Player : CharacterBody2D
@onready var StartPosition : Marker2D
# Called when the node enters the scene tree for the first time.
var screen_size = HUDVariables.get_play_area_size_from_HUD()
var screen_position = HUDVariables.get_play_area_position_from_HUD()
func _ready():
	Player = get_parent().get_node("Player")
	StartPosition = get_parent().get_node("StartPosition")
	Player.start(StartPosition.position)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
