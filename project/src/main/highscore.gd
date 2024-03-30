extends AspectRatioContainer

@export var highscores_container_scene : PackedScene

# Called when the node enters the scene tree for the first time.
#func _ready():
#	var games_list = GameManager.get_games_list()
#
#	%Highscores.clear()
#	var highscore_first_line = "\n[center][b]--- " + "HIGHSCORES" + "  ---[/b][/center]\n\n"
#	%Highscores.append_text(highscore_first_line)
#	for game_key in games_list.keys():
#			var game_first_line = "[b]" + games_list[game_key]['title'] + " Scores[/b]\n"
#			%Highscores.append_text(game_first_line)
#
#			var names = GameManager.get_highscore_names(game_key)
#			var scores = GameManager.get_highscore_scores(game_key)
#
#			for i in range(names.size()):
#				var score_entry = "[indent]" + names[i] + ": " + str(scores[i]) + "\n[/indent]"
#				%Highscores.append_text(score_entry)
#
#			%Highscores.append_text("\n")  # Add an extra newline for separation
#
#	%Highscores.scroll_to_line(0)  # Scroll to the top of the list
func _ready():
	var games_list = GameManager.get_games_list()
	for game_key in games_list.keys():
		var title = games_list[game_key]['title']
		var highscores_container = highscores_container_scene.instantiate()
		highscores_container.create_initials_and_scores(title,game_key)
		%HighscoresVBox.add_child(highscores_container)
