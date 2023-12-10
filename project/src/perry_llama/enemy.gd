extends RigidBody2D
class_name PerryLlamaEnemy

const SPEED = 250.0
signal player_collision
var enemy_sprite : Sprite2D 

func _ready():
	randomize()
	enemy_sprite= $Sprite2D
	var image_number = floor(randf_range(0, 4))
	enemy_sprite.frame = image_number

func _physics_process(_delta):
	linear_velocity.x = -1 * SPEED
#	move_and_slide()
