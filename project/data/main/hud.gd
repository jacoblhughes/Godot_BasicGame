extends CanvasLayer
var score = 0

# Export the NodePath to the player_initials scene
@onready var initials_label = %Initials
@onready var score_label = %Score
signal hud_ready

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func update_initials(value):
	initials_label.text = value
	
func get_initials():
	return(initials_label.text)
	
func set_new_score(new_score):
	score = new_score
	var this_score = str(score)
	score_label.text = this_score
			
func update_score(new_score):
	score += new_score
	var this_score = str(score)
	score_label.text = this_score
		
func reset_score():
	score=0
	score_label.text = str(score)
