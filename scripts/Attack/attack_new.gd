extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	_game_initialize()
	pass # Replace with function body.
#	enemy_spawn_timer = get_parent().get_node("Enemy_Spawn_Timer")
#	player = get_parent().get_node("Player")

func _game_initialize():
	GameManager.reset_score()
	GameManager.startButtonPressed.connect(_on_play_button_pressed)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	GameManager.set_game_enabled(true)
