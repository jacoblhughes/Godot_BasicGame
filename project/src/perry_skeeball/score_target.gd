extends Node3D

signal scored
# Called when the node enters the scene tree for the first time.
func _ready():
	%ScoreZone.score_zone_entered.connect(_on_score_zone_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_score_zone_entered():
	scored.emit()
