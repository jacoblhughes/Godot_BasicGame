@tool
extends ParallaxBackground

@export var combined_texture : Texture2D

@onready var background_parallax : ParallaxLayer = $Background
@onready var back_parallax : ParallaxLayer = $Back
@onready var foreground_parallax : ParallaxLayer = $Foreground
@onready var front_parallax : ParallaxLayer = $Front

@onready var background_animatedsprite = $Background/AnimatedSprite2D
@onready var back_animatedsprite = $Back/AnimatedSprite2D
@onready var foreground_animatedsprite = $Foreground/AnimatedSprite2D
@onready var front_animatedsprite = $Front/AnimatedSprite2D
var speed = 10
var dimensions_set = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set textures and create animations
	set_animation_sprite_texture(background_animatedsprite, combined_texture, 0)
	set_animation_sprite_texture(back_animatedsprite, combined_texture, 1)
	set_animation_sprite_texture(foreground_animatedsprite, combined_texture, 2)
	set_animation_sprite_texture(front_animatedsprite, combined_texture, 3)
	pass # Replace with function body.

# Function to set the texture and create animations
func set_animation_sprite_texture(animated_sprite: AnimatedSprite2D, texture: Texture2D, layer: int):
	var frames = 16
	var frame_width = 360
	var frame_height = 640
	var y_offset = layer * frame_height
	var sprite_frames = SpriteFrames.new()


	for i in range(frames):
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = texture
		var x_offset = i * frame_width
		var frame_region = Rect2(Vector2(x_offset, y_offset), Vector2(frame_width, frame_height))
		atlas_texture.set_region(frame_region)
		sprite_frames.add_frame("default", atlas_texture,1,i)
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.set_autoplay("default")
	animated_sprite.play("default")


func _physics_process(delta):
	if dimensions_set:
		background_parallax.motion_offset.x -= speed * delta * 1
		back_parallax.motion_offset.x -= speed * delta * 3
		foreground_parallax.motion_offset.x -= speed * delta * 6
		front_parallax.motion_offset.x -= speed * delta * 10
	pass

func get_resize_dimensions(xatio,yatio):
	var array_to_change = [background_animatedsprite,back_animatedsprite,foreground_animatedsprite,front_animatedsprite]
	for node in array_to_change:
		node.scale.y *= yatio
		node.scale.x *= xatio
	var array_to_mirror = [background_parallax,back_parallax,foreground_parallax,front_parallax]
	for node in array_to_mirror:
		node.motion_mirroring.y *= yatio
		node.motion_mirroring.x *= xatio
	dimensions_set = true
	pass
