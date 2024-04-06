extends Node3D




# Called when the node enters the scene tree for the first time.
func _ready():
	Background.visible = false
	%StartingArea.cover_input.connect(_on_cover_input)

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

func _on_cover_input(event,input_position):
	if event is InputEventScreenTouch and event.pressed:
		set_up_new_ball()

func set_up_new_ball():
	var skeeballs = get_tree().get_nodes_in_group("skeeballs")
	if len(skeeballs)>0:
		var next_ball = skeeballs[0]
		next_ball.get_ready(%StartingPoint.global_position)
	pass
