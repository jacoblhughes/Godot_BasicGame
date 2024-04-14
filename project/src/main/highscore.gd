extends Control

@export var highscores_container_scene : PackedScene

func _ready():
	%Button.pressed.connect(_on_home_button_pressed)
	
	var games_list = GameManager.get_games_list()
	for game_key in games_list.keys():
		var title = games_list[game_key]['title']
		var highscores_container = highscores_container_scene.instantiate()
		highscores_container.create_initials_and_scores(title,game_key)
		%HighscoresVBox.add_child(highscores_container)

func _on_home_button_pressed():
	HUD.home_button_pressed()
	pass
