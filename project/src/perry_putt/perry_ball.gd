extends RigidBody2D
class_name PlayerPutt
@export var clickable_area : Node2D
@export var hit_meter : CanvasLayer
var adjusted_direction : Vector2
var impulse_direction
const strength = 5
var arrow_direction
# Called when the node enters the scene tree for the first time.
func _ready():

	clickable_area.clickable_input_event.connect(_on_clickable_input)
	hit_meter.send_value.connect(_on_hit_meter_value)
#	apply_impulse(Vector2(200,170)*5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func hide_arrow():
	%Aim.visible = false

func show_arrow():
	%Aim.visible = true

func _on_clickable_input(event, input_position):
	if GameManager.get_game_enabled():
		if event is InputEventMouseButton:
			adjusted_direction = (input_position - global_position).normalized()
			$Aim.rotation = atan2(adjusted_direction.y, adjusted_direction.x) - global_rotation

func _on_hit_meter_value(progress_value):
	var arrow_global_direction = Vector2(cos($Aim.rotation + rotation), sin($Aim.rotation + rotation))
	apply_impulse(arrow_global_direction * progress_value * strength)

	hit_meter.clear()
