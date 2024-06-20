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
	var sprite_frames = SpriteFrames.new()
	var animation_name = "default"
	var base_region = pixel_region
	base_region.size.x *= 1
	base_region.size.y *= 1
	for h in range(HFRAMES):
		var texture = AtlasTexture.new()
		texture.atlas = drawings_png
		var region = Rect2(base_region.position + Vector2(h * base_region.size.x, 0), base_region.size)
		texture.region = region
		sprite_frames.add_frame(animation_name, texture)
	drawings_animation.sprite_frames = sprite_frames
	drawings_animation.play(animation_name)
