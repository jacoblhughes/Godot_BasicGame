extends AspectRatioContainer


# Called when the node enters the scene tree for the first time.
func _ready():

	%BackgroundOnOff.button_pressed = AudioManager.get_background_music_status()
	%GameEffectsOnOff.button_pressed = AudioManager.get_game_music_status()
	%BackgroundVolume.value = AudioManager.get_background_music_level()
	%GameEffectsVolume.value = AudioManager.get_game_music_level()
	pass # Replace with function body.

func _on_check_button_pressed():
	AudioManager.set_background_music_mute(%BackgroundOnOff.button_pressed)
	pass # Replace with function body.


func _on_check_button_2_pressed():
	AudioManager.set_game_music_mute(%GameEffectsOnOff.button_pressed)
	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	AudioManager.update_background_music(value)
	pass # Replace with function body.


func _on_h_slider_2_value_changed(value):
	AudioManager.update_game_music(value)
	pass # Replace with function body.


func _on_reset_high_scores_pressed():
	GameManager.reset_high_scores()
	pass # Replace with function body.
