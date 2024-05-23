extends RigidBody2D
class_name PerryDodgeEnemy

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var choice = mob_types[randi_range(0,2)]
	if choice == "flying":
		AudioManager.play_sound("perry_dodge_squeak")
	elif choice == "swimming":
		AudioManager.play_sound("perry_dodge_chirp")
	else:
		AudioManager.play_sound("perry_dodge_bubbles")
	$AnimatedSprite2D.play(choice)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
