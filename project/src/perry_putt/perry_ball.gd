
extends RigidBody2D
class_name PlayerPutt
@export var clickable_area : Node2D
@export var hit_meter : CanvasLayer
const strength = 5
var target_position : Vector2 = Vector2.ZERO # Holds the latest input position

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.clickable_input_event.connect(_on_clickable_input)
	hit_meter.send_value.connect(_on_hit_meter_value)

func hide_arrow():
	$Aim.visible = false

func show_arrow():
	$Aim.visible = true

func _process(delta):
	if GameManager.get_game_enabled():
		var adjusted_direction = (target_position - global_position).normalized()
		$Aim.rotation = adjusted_direction.angle() - rotation

func _on_clickable_input(event, input_position):
	if event is InputEventScreenTouch:
		target_position = input_position

func _on_hit_meter_value(progress_value):
	var arrow_global_direction = Vector2(cos($Aim.rotation + rotation), sin($Aim.rotation + rotation))
	apply_impulse(arrow_global_direction * progress_value * strength)
	AudioManager.play_sound("perry_putt_ball_hit")
	hit_meter.clear()
