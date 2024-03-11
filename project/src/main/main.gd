extends Control

signal main_ready
@onready var background : ColorRect = %Background
@onready var aspect_ratio_container = %AspectRatioContainer
@onready var center_container = %CenterContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	main_ready.emit()

	pass # Replace with function body.

			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	pass


