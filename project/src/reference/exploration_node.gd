extends Node

func _ready():
	if get_parent():
		iterate_children(get_parent())
	%Timer.timeout.connect(_on_timer_timeout)

func iterate_children(node):
	for child in node.get_children():
		if child is Node2D:
			var scale_x = child.scale.x
			var scale_y = child.scale.y
			if scale_x != 1 and scale_y != 1:
				print("Node: ", child.name, " Scale X: ", scale_x, " Scale Y: ", scale_y)
			if child.get_child_count() > 0:
				iterate_children(child)

func _on_timer_timeout():
	iterate_children(get_parent())
