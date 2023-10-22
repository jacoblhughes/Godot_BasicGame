extends Node2D

@onready var HUDSIGNALS = get_tree().get_root().get_node("Main").get_node("HUD_SCENE")
@onready var SpawnTimer : Timer = get_parent().get_node("SpawnTimer")
# Called when the node enters the scene tree for the first time.
func _ready():
	HUDSIGNALS.startButtonPressed.connect(_on_play_button_pressed)
	SpawnTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	
