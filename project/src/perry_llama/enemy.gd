extends CharacterBody2D


const SPEED = 200.0
signal player_collision
var normal_texture = preload("res://textures/perry_llama/bookcase_256.png")
var wide_texture = preload("res://textures/perry_llama/carrot_256.png")
var clock_texture = preload("res://textures/perry_llama/clock_256.png")
var cactus_texture = preload("res://textures/perry_llama/cactus_256.png")
var pizza_texture = preload("res://textures/perry_llama/pizza_256.png")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var all_textures = [book_texture, carrot_texture,clock_texture,cactus_texture,pizza_texture] # ... add other textures

func _ready():
	randomize()
	var size = randf_range(1, 3)  # Random duration between 1 and 10 seconds
	var image_number = randf_range(1, 4)
	if size ==1:
		scale = Vector2(1,1)
	elif size == 2:
		scale  = Vector2(2,1)
		
	elif size ==3:
		scale  = Vector2(1,2)
		
		$Sprite2D.global_position += $Sprite2D.height/2

func _physics_process(_delta):
	velocity.x = -1 * SPEED
	move_and_slide()
