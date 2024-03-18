extends Area2D
signal hit

var player_collision = true
@onready var CollisionShape : CollisionShape2D
@export var speed = 400 # How fast the player will move (pixels/sec).

@onready var start_position : Marker2D

var target_position
var lerp_speed = 0.1
var is_touching = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = get_parent().get_node('StartPosition')
	target_position = start_position.global_position
	
#	PlayArea.in_play_area.connect(_on_in_play_area)
	%ClickableArea.clickable_input_event.connect(_on_clickable_input_event)
	start(target_position)
	
func _on_clickable_input_event(event,input_position):
	if event.pressed:
		target_position = input_position
		if(GameManager.get_game_enabled()):
		# Check for touch events


			var to_target = target_position - global_position
			var direction = to_target.normalized()

			if(abs(direction.x)>abs(direction.y)):
				$AnimatedSprite2D.play("walking")
				if(direction.x>0):
					$AnimatedSprite2D.flip_h = true
				else:
					$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.play("up")
				if(direction.y>0):
					$AnimatedSprite2D.flip_v = true
				else:
					$AnimatedSprite2D.flip_v = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

#	var mouse_pos = get_viewport().get_mouse_position()
#	target_y = mouse_pos.y
	if target_position != null:
		global_position = global_position.lerp(target_position, lerp_speed)
	global_position.x = clamp(global_position.x, %ClickableArea.get_play_area_position().x,%ClickableArea.get_play_area_position().x+%ClickableArea.get_play_area_size().x)
	global_position.y = clamp(global_position.y, %ClickableArea.get_play_area_position().y,%ClickableArea.get_play_area_position().y+%ClickableArea.get_play_area_size().y)



func _on_body_entered(body):
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	$CollisionShape2D.set_deferred("disabled", false)


