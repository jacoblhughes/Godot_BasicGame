
extends Control



# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func create_initials_and_scores(title,game_key):
#	%Title.text = title
##	%Title.text = "[b]" + title +  "[/b]"
##	%Title.fit_content = true
#	var names = GameManager.get_highscore_names(game_key)
#	var scores = GameManager.get_highscore_scores(game_key)
#	for i in range(names.size()):
#		var names_label = Label.new()
#		names_label.text = names[i]
#		names_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#		names_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
##		names_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
##		names_label.size_flags_horizontal = Control.SIZE_EXPAND
#		%InitialsBox.add_child(names_label)
#	for i in range(scores.size()):
#		var scores_label = Label.new()
#		scores_label.text = str(scores[i])
#		scores_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#		scores_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
#		%ScoresBox.add_child(scores_label)

func create_initials_and_scores(title,game_key):
	%Title.text = title
#	%Title.text = "[b]" + title +  "[/b]"
#	%Title.fit_content = true
	var names = GameManager.get_highscore_names(game_key)
	var scores = GameManager.get_highscore_scores(game_key)
	for i in range(names.size()):
		if i < 5:
			var rank_label = Label.new()
			var rank = i + 1
			rank_label.text = str(rank)
			rank_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			rank_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			rank_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	#		names_label.size_flags_horizontal = Control.SIZE_EXPAND
			%RankBox1.add_child(rank_label)
		elif i > 4:
			var rank_label = Label.new()
			var rank = i + 1
			rank_label.text = str(rank)
			rank_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			rank_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			rank_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	#		names_label.size_flags_horizontal = Control.SIZE_EXPAND
			%RankBox2.add_child(rank_label)
	for i in range(names.size()):
		if i < 5:
			var names_label = Label.new()
			names_label.text = names[i]
			names_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			names_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			names_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	#		names_label.size_flags_horizontal = Control.SIZE_EXPAND
			%InitialsBox1.add_child(names_label)
		elif i > 4:
			var names_label = Label.new()
			names_label.text = names[i]
			names_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			names_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			names_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	#		names_label.size_flags_horizontal = Control.SIZE_EXPAND
			%InitialsBox2.add_child(names_label)
	for i in range(scores.size()):
		if i < 5:
			var scores_label = Label.new()
			scores_label.text = str(scores[i])
			scores_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			scores_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			scores_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
			%ScoresBox1.add_child(scores_label)
		elif i > 4:
			var scores_label = Label.new()
			scores_label.text = str(scores[i])
			scores_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			scores_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			scores_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
			%ScoresBox2.add_child(scores_label)
