extends ParallaxBackground

@export var texture: CompressedTexture2D

@onready var parallax = $ParallaxLayer
@onready var sprite = $ParallaxLayer/Sprite2D

@export var speed = 10
var scroll = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = texture

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	scroll_offset.x -= speed * delta
#	scroll = speed * delta
#	parallax.set_motion_offset(Vector2(scroll,0))

#	sprite.region_rect.position += delta * far_scroll_speed
#	if far_sprite.region_rect.position >= Vector2(1024,0):
#		far_sprite.region_rect.position = Vector2.ZERO
	pass
