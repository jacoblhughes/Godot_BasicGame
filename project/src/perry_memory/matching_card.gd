extends Node2D

@export var drawings_animation : AnimatedSprite2D
@export var card_animation : AnimatedSprite2D

func _process(delta):
	pass


func _ready():
	drawings_animation.play("default")
	card_animation.play("default")
	pass
	#var sprite_frames = SpriteFrames.new()
	#var animation_name = "default"
	#var base_region = pixel_region
	#base_region.size.x *= 1
	#base_region.size.y *= 1
	#for h in range(HFRAMES):
		#var texture = AtlasTexture.new()
		##texture.atlas = drawings_png
		#var region = Rect2(base_region.position + Vector2(h * base_region.size.x, 0), base_region.size)
		#texture.region = region
		#sprite_frames.add_frame(animation_name, texture)
	#drawings_animation.sprite_frames = sprite_frames
	#drawings_animation.play(animation_name)
