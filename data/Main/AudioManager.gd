extends Node

# Export the NodePath to the player_initials scene
var config = ConfigFile.new()

@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():


	GameOverSound = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("GameOver")
	ApplauseSound = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("Applause")
	BackGroundMusic = get_tree().get_root().get_node("Main").get_node("HUD").get_node("Control").get_node("BackGroundMusic")
