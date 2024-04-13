extends Node2D


var hit_spot
var hit_color := Color.TRANSPARENT
@onready var snake := get_parent() as Snake

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().dimensions_ready.connect(_on_dimensions_ready)

	snake.hit.connect(_on_snake_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	queue_redraw()
	
func _draw():
	draw_rect(hit_spot,hit_color)
	

func _on_snake_hit(minisnake_hit: Minisnake) -> void:

	hit_spot.position = Vector2(minisnake_hit.curr_position)
	hit_color = Color.BLUE

func _on_dimensions_ready():
	hit_spot = Rect2(Vector2.ZERO,  get_parent().return_snake_cell_size())
