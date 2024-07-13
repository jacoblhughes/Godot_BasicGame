extends CanvasLayer

signal start_button_pressed
signal game_over

var countdown = 3

func _ready():
	for node in [%GameStartPanel,%GameOverPanel,%Countdown]:
		if node.visible:
			node.hide()
	%PlayButton.pressed.connect(_on_play_button_pressed)
	%HomeButtonOnGameover.pressed.connect(_on_home_button_pressed)
	%CountdownTimer.timeout.connect(_on_countdown_timer_timeout)
	if %HighscoreAchieved.visible:
		%HighscoreAchieved.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func out_of_lives():
	show()
	game_over.emit()
	set_gameover_panel(true)
	GameManager.set_game_enabled(false)
	GameManager.check_highscore_and_rank()
	Interruptions.reset_glitch()

func game_start_game_over_initialize( this_start_button_callable, this_game_over_callable):
	start_button_pressed.connect(this_start_button_callable)
	game_over.connect(this_game_over_callable)
	pass

func set_game(flag,title,objective,directions):
	%GameStartPanel.visible = flag
	%Objective.text = objective
	%Title.text=title
	%Directions.text = directions


func _on_play_button_pressed():
	%GameStartPanel.visible = false
	%CountdownLabel.text = str(countdown)
	%Countdown.show()

	%CountdownTimer.start()


	pass # Replace with function body.

func _on_countdown_timer_timeout():

	if countdown == 3 or countdown == 2:
		countdown -= 1
		%CountdownLabel.text = str(countdown)
		return
	elif countdown == 1:
		%Countdown.hide()
		%CountdownTimer.stop()
		start_button_pressed.emit()
		Interruptions.start_interruptions_timer()
		countdown = 3
		self.hide()
		return

func set_gameover_panel(flag):
	%GameOverPanel.visible = flag

func set_gamestart_panel(flag):
	%GameStartPanel.visible = flag

func set_gameover_panel_congrats(vis):
	%GameOverPanel.visible = vis
	if(vis):

		%HighscoreAchieved.visible = true
	else:

		%HighscoreAchieved.visible = false

func _on_home_button_pressed():
	HUD.home_button_pressed()

	self.hide()
