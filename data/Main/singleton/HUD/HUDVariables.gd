extends Node

# Export the NodePath to the player_initials scene
@onready var player_initials = PlayerVariables.get_initials()
@onready var InitialsInput : Label
@onready var ScoreLabel : Label
@onready var StatusLabel : Label
@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer
@onready var PlayArea: ColorRect
var child_node_to_delete

@onready var buttons  = get_tree().get_root().get_node("Main").get_node("Buttons")
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():	
	InitialsInput = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Initials")
	ScoreLabel = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Score")
	StatusLabel = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameStatus")
	GameOverSound = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("GameOver")
	ApplauseSound = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("Applause")
	BackGroundMusic = get_tree().get_root().get_node("Main").get_node("HUD_SCENE").get_node("Control").get_node("BackGroundMusic")
	PlayArea = get_tree().get_root().get_node("Main").get_node("PlayArea")
func set_new_score(new_score):
		if new_score == 0:
			score = 0
			var this_score = str(score)
			ScoreLabel.text = this_score
		else:
			score += new_score
			var this_score = str(score)
			ScoreLabel.text = this_score
		
func set_new_status(status):
		StatusLabel.text = status

func play_game_over():
	GameOverSound.play()

func play_applause():
	ApplauseSound.play()
	
func get_initials_from_HUD() -> String:
	return InitialsInput.text

func get_play_area_size_from_HUD():
	return PlayArea.size
	
func get_play_area_position_from_HUD():
	return PlayArea.position

func get_current_score():
	return ScoreLabel.text
