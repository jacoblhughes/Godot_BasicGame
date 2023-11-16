extends Control

# Export the NodePath to the player_initials scene
@onready var player_initials = GameManager.get_initials()
@onready var InitialsInput : Label
@onready var ScoreLabel : Label
@onready var StatusLabel : Label
@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer

@onready var GameStartPanel : CanvasLayer

signal hud_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	hud_ready.emit()
	pass
