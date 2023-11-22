extends Node2D

var high_score_popup_list : RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	var games_list = GameManager.get_games_list()
	high_score_popup_list = $RichTextLabel
	high_score_popup_list.clear()
	var highscore_first_line = "\n[center][b]--- " + "HIGHSCORES" + "  ---[/b][/center]\n\n"
	high_score_popup_list.append_text(highscore_first_line)
	for game_key in games_list.keys():
			var game_first_line = "[b]" + games_list[game_key]['title'] + " Scores[/b]\n"
			high_score_popup_list.append_text(game_first_line)

			var names = GameManager.get_highscore_names(game_key)
			var scores = GameManager.get_highscore_scores(game_key)

			for i in range(names.size()):
				var score_entry = "[indent]" + names[i] + ": " + str(scores[i]) + "\n[/indent]"
				high_score_popup_list.append_text(score_entry)

			high_score_popup_list.append_text("\n")  # Add an extra newline for separation

	high_score_popup_list.scroll_to_line(0)  # Scroll to the top of the list


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
