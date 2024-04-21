extends CharacterBody2D
class_name PerryRunPlayer

const JUMP_VELOCITY = -750.0
const MAX_JUMP_TIME = 0.2  # Maximum time the jump button can be held
var gravity = 1200
var jump_time = 0.0  # Time for which the jump button is held
var xpos

func _ready():
	# Ensure there's a Tween node; add it from the script if it's not manually added in the editor
	pass

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_time = 0  # Start counting jump time

	elif Input.is_action_pressed("ui_accept") and not is_on_floor() and jump_time < MAX_JUMP_TIME:
		jump_time += delta
		velocity.y -= 35

	move_and_slide()
	correct_x_position()

func set_xpos(pos):
	xpos = pos

func correct_x_position():
	if position.x != xpos and xpos:
		var tween_move = create_tween()
		tween_move.tween_property(self, "position:x", xpos, .1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)







#extends CharacterBody2D
#class_name PerryRunPlayer
#
#
#const JUMP_VELOCITY = -400.0
#const MAX_JUMP_TIME = 0.2  # Maximum time the jump button can be held
#var gravity = 1200
#var jump_time = 0.0  # Time for which the jump button is held
#var xpos
#func _ready():
#
#	pass
#
#func _physics_process(delta):
#	print(is_on_floor())
#	# Add the gravity.
#
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#		jump_time = 0  # Start counting jump time
##
#	# Check if jump button is held
#	elif Input.is_action_pressed("ui_accept") and not is_on_floor() and jump_time < MAX_JUMP_TIME:
#		jump_time += delta
#		velocity.y -= 50  # This value controls the additional jump force per frame
#
#	move_and_slide()
#
#	position.x = clamp(position.x,xpos,xpos)
#
#func set_xpos(pos):
#	xpos = pos
