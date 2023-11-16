extends CharacterBody2D


const SPEED = 200.0
signal player_collision
var book_texture = preload("res://art/Dino/bookcase_256.png")
var carrot_texture = preload("res://art/Dino/carrot_256.png")
var clock_texture = preload("res://art/Dino/clock_256.png")
var cactus_texture = preload("res://art/Dino/cactus_256.png")
var pizza_texture = preload("res://art/Dino/pizza_256.png")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var all_textures = [book_texture, carrot_texture,clock_texture,cactus_texture,pizza_texture] # ... add other textures

func _ready():
	var chosen_texture = all_textures[randi() % all_textures.size()]
	$Sprite2D.texture = chosen_texture

func _physics_process(delta):
	velocity.x = -1 * SPEED
	move_and_slide()
