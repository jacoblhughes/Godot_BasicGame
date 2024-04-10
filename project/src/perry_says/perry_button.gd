extends TouchScreenButton
@onready var sprite_number : int = 0
@onready var button_number : int = 1
#@onready var animated_sprite : AnimatedSprite2D
var audio_stream_player : AudioStreamPlayer
#@onready var texture_button : TextureButton
signal perry_pressed
var original_time = .75
var play_time

func _ready():
	play_time = original_time
#	texture_button = $TextureButton
#	animated_sprite = $TextureButton/AnimatedSprite2D
	audio_stream_player = %AudioStreamPlayer
	pass

func initiate_button():


	var total_columns = 16
	var desired_column = sprite_number

	var button_texture = preload("res://textures/perry_says/perry_says_buttons_256.png")
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
	texture_normal = atlas_texture
	texture_pressed = pressed_atlas_texture
#	var sprite_frames = SpriteFrames.new()
#	sprite_frames.clear_all()
##	sprite_frames.add_animation('default')
#	sprite_frames.add_frame('default',atlas_texture,1,0)
#	sprite_frames.add_animation('pressed')
#	sprite_frames.add_frame('pressed',pressed_atlas_texture,1,0)
#	animated_sprite.set_sprite_frames(sprite_frames)
#	animated_sprite.set_animation("default")

	# Adjust other properties as needed
#	animated_sprite.scale = Vector2(0.75, 0.75)
#	size = Vector2(192, 192)


func _on_texture_button_pressed():
#	animated_sprite.play('pressed')
	perry_pressed.emit(button_number)
	audio_stream_player.play()
	await get_tree().create_timer(play_time).timeout
	audio_stream_player.stop()
#	animated_sprite.stop()
#	animated_sprite.play('default')
	pass # Replace with function body.

func called_from_game():
	_on_texture_button_pressed()
