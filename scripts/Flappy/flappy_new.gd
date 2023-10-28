extends Node2D


@onready var SpawnTimer : Timer = get_parent().get_node("SpawnTimer")
signal startgame
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.startButtonPressed.connect(_on_play_button_pressed)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	startgame.emit()
	SpawnTimer.start()
	pass
