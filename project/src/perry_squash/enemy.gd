extends CharacterBody2D
class_name PerrySquashEnemy

var speeding = false
var speed_timer : Timer
var fast_speed = 150
var slow_speed = 25
var fast_time = 0.70
var slow_time = 0.20
var speed = 0
var direction = 0
var cause_pain = false
var good_or_bad
signal enemy_squashed


# Called when the node enters the scene tree for the first time.
func _ready():
	if good_or_bad:
		cause_pain = false
		%AnimatedSprite2D.set_animation("default")
	else:
		cause_pain = true
		%AnimatedSprite2D.set_animation("pain")
	speed_timer = Timer.new()
	speed_timer.wait_time = slow_time
	speed_timer.timeout.connect(_on_speed_timers_timeout)
	add_child(speed_timer)

	speed_timer.start()
	speed = slow_speed

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = speed * direction
	move_and_slide()
	if %ShapeCast2D.is_colliding():
		var collider = %ShapeCast2D.get_collider(0)
		if collider is PerrySquashPlayer and cause_pain:
			collider.take_damage()
		elif collider is PerrySquashPlayer and !cause_pain:
			enemy_squashed.emit()
			die()
	pass

func die():
	queue_free()
	AudioManager.play_sound("perry_squash_snake_hit")

func set_direction(val):
	if val == 1:
		direction = 1
		%AnimatedSprite2D.flip_h = true
	elif val == -1:
		direction = -1

func _on_speed_timers_timeout():
	if speeding:
		speed_timer.wait_time = slow_time
		speed_timer.start()
		speed = slow_speed
		speeding = false
		%AnimatedSprite2D.set_frame(1)
	else:
		speed_timer.wait_time = fast_time
		speed_timer.start()
		speed = fast_speed
		speeding = true
		%AnimatedSprite2D.set_frame(0)
