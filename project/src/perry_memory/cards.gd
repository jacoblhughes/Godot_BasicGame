extends Node2D

@export var matching_card_scene : PackedScene
@export var drawings_png : Texture
@export var card_width : int = 32
@export var card_height : int = 48

# Called when the node enters the scene tree for the first time.
func _ready():

	var animation_name = "default"
	var texture_width = drawings_png.get_width()
	var texture_height = drawings_png.get_height()

	var cards_horizontal = texture_width / card_width
	var cards_vertical = texture_height / card_height

	for v in range(cards_vertical):
		var sprite_frames = SpriteFrames.new()
		var matching_card = matching_card_scene.instantiate()
		for h in range(cards_horizontal):
			var texture = AtlasTexture.new()
			texture.atlas = drawings_png
			var region = Rect2(Vector2(h * card_width, v * card_height), Vector2(card_width, card_height))
			texture.region = region
			sprite_frames.add_frame(animation_name, texture,1.0,-1)
		matching_card.drawings_animation.sprite_frames = sprite_frames
		matching_card.position += Vector2(50,50) * v
		add_child(matching_card)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
