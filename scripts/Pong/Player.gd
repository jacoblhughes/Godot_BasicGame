extends RigidBody2D

@onready var my_sprite : ColorRect
@onready var collision_object : CollisionShape2D
@onready var ball : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	my_sprite = $ColorRect
	collision_object=$CollisionShape2D
	ball = get_parent().get_node("Ball")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	position.y = mouse_pos.y
	position.y = clamp(position.y, HUDVariables.PlayArea.global_position.y + my_sprite.size.y/2,HUDVariables.PlayArea.global_position.y+HUDVariables.PlayArea.size.y - my_sprite.size.y/2)
