extends CanvasLayer
@export var game_background_texture : Texture
@export var stretch_mode_tile : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	%TextureRect.texture = game_background_texture
	if stretch_mode_tile:
		%TextureRect.stretch_mode = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
