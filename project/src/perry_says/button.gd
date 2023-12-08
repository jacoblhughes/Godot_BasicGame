extends Node2D
@export var button_number : int = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _ready():
	# Assuming you already have a TextureButton named "my_texture_button" in your scene
	var button = $TextureButton
	var animated_sprite = $TextureButton/AnimatedSprite2D
	# Create an AtlasTexture instance
	var total_columns = 16
	var desired_column = button_number
	# Define the desired column (0-based index)
	var button_texture = preload("res://textures/perry_says/perry_simon_buttons_backgrounds_256.png")
	var atlas_texture = AtlasTexture.new()
	var pressed_atlas_texture = AtlasTexture.new()
	# Assign the atlas texture to the AtlasTexture instance
	atlas_texture.atlas = button_texture
	pressed_atlas_texture.atlas = button_texture
	var texture_width = atlas_texture.get_width()/total_columns
	# Calculate the size of each individual texture in the sprite sheet

	# Calculate the region rect for the desired column
	var column_index = desired_column % total_columns
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

	# Create an AtlasTexture instance

	# Set the region rect for the normal state
	atlas_texture.set_region(region_rect)
	pressed_atlas_texture.set_region(pressed_region_rect)
	# Assign the AtlasTexture to the button's texture_normal property
	animated_sprite.set_animation("default")
	animated_sprite.set_animation("pressed")
	animated_sprite.get_animation('default')
	animated_sprite.set_sprite_frames(atlas_texture)
	# Adjust other properties as needed
	animated_sprite.scale = Vector2(0.75, 0.75)
	button.size = Vector2(192, 192)


func _on_texture_button_pressed():
	print('rrrrr')
	pass # Replace with function body.
