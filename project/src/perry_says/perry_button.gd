extends Node2D
@onready var sprite_number : int = 0
@onready var button_number : int = 1

signal perry_pressed
var original_time = .75
var play_time
@export var button_texture : Resource
var audio_string = null

func _ready():
	play_time = original_time
	%Button.pressed.connect(_on_texture_button_pressed)
	pass

func initiate_button():
	var total_columns = 16
	var desired_column = sprite_number

	var atlas_texture = AtlasTexture.new()
	var pressed_atlas_texture = AtlasTexture.new()

	atlas_texture.atlas = button_texture
	pressed_atlas_texture.atlas = button_texture

	var texture_width = atlas_texture.get_width()/total_columns

	var column_index = (desired_column % total_columns)

	var pressed_column_index = desired_column+1 % total_columns

	var region_rect = Rect2(
		column_index * texture_width,
		0,  # Since there is only one row, the row index is always 0
		texture_width,
		texture_width  # Assuming square textures, adjust if necessary
	)
	var pressed_region_rect = Rect2(
		pressed_column_index * texture_width,
		0,  # Since there is only one row, the row index is always 0
		texture_width,
		texture_width  # Assuming square textures, adjust if necessary
	)

	atlas_texture.set_region(region_rect)
	pressed_atlas_texture.set_region(pressed_region_rect)
	%Button.texture_normal = atlas_texture
	%Button.texture_pressed = pressed_atlas_texture


func _on_texture_button_pressed():

	perry_pressed.emit(button_number)
	AudioManager.play_sound(audio_string)
	#audio_stream_player.play()
	#await get_tree().create_timer(play_time).timeout
	#audio_stream_player.stop()

	pass # Replace with function body.

func called_from_game():

	%Button.pressed.emit()
	%Button.toggle_mode = true
	%Button.button_pressed = true
	await get_tree().create_timer(play_time).timeout
	%Button.button_pressed = false
	%Button.toggle_mode = false
