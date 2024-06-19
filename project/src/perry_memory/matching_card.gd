extends Node2D

@export var drawings_png : Texture
@export var drawings_animation : AnimatedSprite2D
var selection = 1
var pixel_region = Rect2(Vector2(0,0),Vector2(32,48))
# Called when the node enters the scene tree for the first time.
# Replace with function body.
const HFRAMES = 17
const VFRAMES = 12
const ANIMATION_LENGTH = 17


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _ready():

	# Create a new SpriteFrames resource
	var sprite_frames = SpriteFrames.new()

	var animation_name = "default"

	var region = pixel_region * Vector2(1,HFRAMES)
	var texture = AtlasTexture.new()
	texture.region = region
	texture.atlas = drawings_png
	for h in range(HFRAMES):
		sprite_frames.add_frame(animation_name, texture*(h/HFRAMES), 1, 16-h)

	# Assign the created SpriteFrames to AnimatedSprite2D
	drawings_animation.sprite_frames = sprite_frames

	# Play the first layer's animation
	#drawings_animation.play("layer_0")
