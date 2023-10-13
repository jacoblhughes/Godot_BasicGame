extends CharacterBody2D
var reset_round = false
@onready var HUDSIGNALS = get_tree().get_root().get_node("Main").get_node("HUD_SCENE")
@onready var PONGSIGNALS = get_tree().get_root().get_node("Main").get_node("GameScene").get_node("Perry").get_node("pong")
# Called when the node enters the scene tree for the first time.
var position_reset = false
var original_position = Vector2(0,0)


func _ready():
	HUDSIGNALS.startButtonPressed.connect(_on_play_button_pressed)
	HUDSIGNALS.resetButtonPressed.connect(_on_reset_button_reset_button_pressed)
	PONGSIGNALS.position_reset.connect(_on_position_reset)
	original_position = position
	reset_round = true
	pass # Replace with function body.
var collision_cooldown: float = 1.0
const COLLISION_COOLDOWN_DURATION: float = 0.2  # 0.2 seconds, adjust as needed

func _physics_process(delta):
#	print(collision_cooldown)
	if collision_cooldown > 0:
		collision_cooldown -= delta

	var collision = move_and_collide(velocity * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())*1.1
		move_and_collide(reflect)
		
#	move_and_slide()
#	for i in range(get_slide_collision_count()):
#		# Check if cooldown is active
#		if collision_cooldown > 0:
#			continue
#
#		var collision = get_slide_collision(i)
#
#		if(collision.get_collider().name == "Top Wall" or collision.get_collider().name == "Paddle - Computer"):
#			var normal = collision.get_remainder().bounce(collision.get_normal())
#			print(normal)
#			print("Top Wall: ")
#			velocity = velocity.bounce(normal)
#			print(velocity)


func _on_play_button_pressed():
	if reset_round:
		reset_round = false
	pass
	
func _on_reset_button_reset_button_pressed():
	position_reset = true
	
func _on_position_reset():

	_reset_ball()

func _input(_event):

	if Input.is_action_pressed("left_mouse_click") and reset_round:

		velocity = Vector2(-100,-100)
		reset_round = false

func _reset_ball():
	position_reset = true
	position = original_position
	velocity = Vector2(0,0)
	position_reset = false
	reset_round = true
