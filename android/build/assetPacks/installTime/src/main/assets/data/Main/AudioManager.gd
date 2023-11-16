extends Node

# Export the NodePath to the player_initials scene
var config = ConfigFile.new()

@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer
@onready var hud_control : Control
@onready var aspect_ratio_container :Control
# Called when the node enters the scene tree for the first time.
func _ready():
	aspect_ratio_container = get_tree().get_root().get_node("Main").get_node("AspectRatioContainer").get_node("Control")
	hud_control = aspect_ratio_container.get_node("HUD")
	GameOverSound = hud_control.get_node("GameOver")
	ApplauseSound = hud_control.get_node("Applause")
	BackGroundMusic = hud_control.get_node("BackGroundMusic")
	pass
