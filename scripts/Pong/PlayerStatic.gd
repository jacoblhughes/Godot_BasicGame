extends StaticBody2D

@onready var my_sprite : Sprite2D
@onready var collision_object : CollisionShape2D
@onready var ball : RigidBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $Sprite2D
	collision_object=$CollisionShape2D
	ball = get_parent().get_node("Ball")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
#	ball.linear_velocity += Vector2(1,1)
#	my_sprite.y = mouse_pos.y
#	collision_object.y = mouse_pos.y
	# Update the node's position to follow the mouse
	position.y = mouse_pos.y
