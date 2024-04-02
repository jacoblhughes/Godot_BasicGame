extends Node2D


var hit_spot
var hit_color := Color.TRANSPARENT
@onready var snake := get_parent().get_node("PerryPython") as Snake

# Called when the node enters the scene tree for the first time.
func _ready():
	var perry_python = %PerryPython
	hit_spot = Rect2(Vector2.ZERO,  perry_python.return_cell_size())
	snake.hit.connect(_on_snake_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	queue_redraw()
	
func _draw():
	draw_rect(hit_spot,hit_color)
	

func _on_snake_hit(minisnake_hit: Minisnake) -> void:

	hit_spot.position = Vector2(minisnake_hit.curr_position)

#	var tween_pulse = create_tween().set_trans(Tween.TRANS_CIRC).set_loops()
#	tween_pulse.tween_property(self, "hit_color",SnakeVariables.RED, .55).set_ease(Tween.EASE_OUT)
#	tween_pulse.tween_property(self, "hit_color",Color.TRANSPARENT, .55).set_ease(Tween.EASE_IN).set_delay(.1)
	hit_color = %grid.BLUE

