extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("hit_space") and !%HitMeter.meter_status:

		%HitMeter.start_meter()
		
	elif Input.is_action_just_pressed("hit_space") and %HitMeter.meter_status:
		%HitMeter.stop_meter()
		%PerryBall.swing(%HitMeter.return_meter())



