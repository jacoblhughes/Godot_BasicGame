extends Path2D

@onready var enemy_path = $PathFollow2D
@onready var enemy = $PathFollow2D/Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_path.set_progress_ratio(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemy_path.progress_ratio += .25*delta
	if (enemy_path.progress_ratio >=1):
		enemy.queue_free()
	pass
