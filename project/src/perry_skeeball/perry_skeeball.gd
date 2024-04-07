extends Node3D

var active_ball


# Called when the node enters the scene tree for the first time.
func _ready():
	Background.visible = false
	%Shelf.load_ball.connect(_on_load_ball)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("hit_space"):
		if %Camera1.current==true:
			%Camera1.current=false
			%Camera2.current==true
		else:
			%Camera1.current=true
			%Camera2.current=false
	pass

func _on_load_ball(event,input_position):
	if event is InputEventScreenTouch and event.pressed:
		set_up_new_ball()

func set_up_new_ball():
	var skeeballs = get_tree().get_nodes_in_group("skeeballs")
	if len(skeeballs)>0:
		active_ball = skeeballs[0]
		active_ball.get_ready(%StartingPoint.global_position)
	pass


func _on_ball_despawn_body_entered(body):
	if body is PerrySkeeball:
		body.dead_ball()
	pass # Replace with function body.


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		active_ball.shoot()
	pass # Replace with function body.
