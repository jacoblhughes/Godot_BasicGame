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
	velocity = Vector2(-200,-10)
	pass # Replace with function body.
var collision_cooldown: float = 1.0
const COLLISION_COOLDOWN_DURATION: float = 0.2  # 0.2 seconds, adjust as needed
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _integrate_forces(state):
#	print('hee')
#	if position_reset:
#
#		state.transform.origin = original_position
#		state.linear_velocity = Vector2(0,0)
#		position_reset = false
#		print('should be done')
#	else:
#
#		pass

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
		#	self.apply_central_impulse(Vector2(-1,-1) * 200)
	pass
func _on_reset_button_reset_button_pressed():
	position_reset = true
	
func _on_position_reset():

	position_reset = true
	position = original_position
	velocity = Vector2(0,0)
	position_reset = false
	velocity = Vector2(-100,-100)
	
#func _on_body_entered(body):
#	print("Ball hit: ",body.name)
#	if body.name == "Paddle - Computer" or body.name == "Paddle - Player":
#		pass
##		linear_velocity = linear_velocity.normalized() * (linear_velocity.length() * 1.20)
#	if body.name == "Paddle - Computer":
#		pass
##		linear_velocity = Vector2(100,100)
#	if body.name == "Win":
#		position_reset = true
#		HUDSIGNALS.set_new_score(1)
#		reset_round = true
#	if body.name == "Win":
#		position_reset = true
#		HUDSIGNALS.set_new_score(-1)
#		reset_round = true

func _input(event):

	if Input.is_action_pressed("left_mouse_click") and reset_round:
#		linear_velocity = Vector2(-100,-100)
		reset_round = false
