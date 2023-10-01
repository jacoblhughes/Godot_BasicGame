extends CanvasLayer

# Export the NodePath to the player_initials scene
@onready var player_initials = PlayerVariables.get_initials()
@onready var InitialsInput : Label
@onready var ScoreLabel : Label
@onready var StatusLabel : Label
@onready var GameOverSound: AudioStreamPlayer
@onready var ApplauseSound: AudioStreamPlayer
@onready var BackGroundMusic: AudioStreamPlayer
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
	
	update_initials_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	player_initials = PlayerVariables.get_initials()
	InitialsInput.text = player_initials

func update_initials_label():

	if player_initials:
		InitialsInput.text = player_initials
	else:
		print("Player initials instance not found or does not have the 'get_initials' function.")


func _on_home_button_pressed():
	
	child_node_to_delete = get_tree().get_root().get_node("Main").get_node("GameScene").get_children()
	if child_node_to_delete:
		buttons.visible = true
		for child in child_node_to_delete:
			child.queue_free()
	pass # Replace with function body.

func _set_new_score(new_score):
		if new_score == 0:
			score = 0
			var this_score = str(score)
			ScoreLabel.text = this_score
		else:
			score += new_score
			var this_score = str(score)
			ScoreLabel.text = this_score
		
func _set_new_status(status):
		StatusLabel.text = status

func play_game_over():
	GameOverSound.play()
func play_applause():
	ApplauseSound.play()
	
func get_initials_from_HUD() -> String:
	return InitialsInput.text
