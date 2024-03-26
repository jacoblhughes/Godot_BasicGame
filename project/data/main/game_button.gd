extends Button

@export var game_image_texture : CompressedTexture2D
@export var game_scene_selection : PackedScene
@export var game_key_selection : String
@export var game_title : String

signal game_chosen
# Called when the node enters the scene tree for the first time.
func _ready():
	text = game_title
	%TextureRect.texture = game_image_texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	game_chosen.emit(game_key_selection,game_scene_selection)
	pass # Replace with function body.
