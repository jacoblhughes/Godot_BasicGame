extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	$CheckButton.button_pressed = AudioManager.get_background_music_status()
	$CheckButton2.button_pressed = AudioManager.get_game_music_status()
	$HSlider.value = AudioManager.get_background_music_level()
	$HSlider2.value = AudioManager.get_game_music_level()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_check_button_pressed():
	AudioManager.set_background_music_mute($CheckButton.button_pressed)
	pass # Replace with function body.


func _on_check_button_2_pressed():
	AudioManager.set_game_music_mute($CheckButton2.button_pressed)
	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	AudioManager.update_background_music(value)
	pass # Replace with function body.


func _on_h_slider_2_value_changed(value):
	AudioManager.update_game_music(value)
	pass # Replace with function body.
