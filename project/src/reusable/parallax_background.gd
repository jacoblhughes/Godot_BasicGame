extends ParallaxBackground

@export var far_back_texture : AtlasTexture
@export var background_texture : AtlasTexture
@export var foreground_texture : AtlasTexture
@export var foreground_extra_texture : AtlasTexture

@onready var far_back_parallax : ParallaxLayer = $FarBack
@onready var background_parallax : ParallaxLayer = $Background
@onready var foreground_parallax : ParallaxLayer = $Foreground
@onready var foreground_extra_parallax : ParallaxLayer = $ForegroundExtra

@onready var far_background_sprite = $FarBack/Sprite2D
@onready var background_sprite = $Background/Sprite2D
@onready var foreground_sprite = $Foreground/Sprite2D
@onready var foreground_extra_sprite = $ForegroundExtra/Sprite2D

@export var speed = 10
var scroll = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	far_background_sprite.texture = far_back_texture
	background_sprite.texture = background_texture
	foreground_sprite.texture = foreground_texture
	foreground_extra_sprite.texture = foreground_extra_texture
#	sprite.global_position = GameManager.get_play_area_position()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	background_parallax.motion_offset.x -= speed * delta
	foreground_parallax.motion_offset.x -= speed * delta
	foreground_extra_parallax.motion_offset.x -= speed * delta
#	scroll = speed * delta
#	parallax.set_motion_offset(Vector2(scroll,0))

#	sprite.region_rect.position += delta * far_scroll_speed
#	if far_sprite.region_rect.position >= Vector2(1024,0):
#		far_sprite.region_rect.position = Vector2.ZERO
	pass

func get_resize_dimensions(xatio,yatio):
	pass
