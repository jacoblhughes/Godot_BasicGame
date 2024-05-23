extends StaticBody2D
class_name PerryPuttFan

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func activate_collision():
	AudioManager.play_sound("perry_putt_windmill_squeak")
	%CollisionShape2D.call_deferred("set","disabled",false)

func deactivate_collision():
	%CollisionShape2D.call_deferred("set","disabled",true)
