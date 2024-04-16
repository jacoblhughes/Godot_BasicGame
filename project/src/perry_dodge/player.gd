extends Area2D
class_name PerryDodgePlayer


var player_collision = true
@onready var CollisionShape : CollisionShape2D
@export var speed = 400 # How fast the player will move (pixels/sec).

@onready var start_position : Marker2D

var target_position
var lerp_speed = 0.1
var is_touching = false 

# Called when the node enters the scene tree for the first time.
func _ready():	
	HUD.clickable_input_event.connect(_on_clickable_input_event)
	
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


	global_position.x = clamp(global_position.x, HUD.get_play_area_position().x,HUD.get_play_area_position().x+HUD.get_play_area_size().x)
	global_position.y = clamp(global_position.y, HUD.get_play_area_position().y,HUD.get_play_area_position().y+HUD.get_play_area_size().y)


func hit():

	if(GameManager.get_game_enabled()):
		HUD.update_lives()

	
func start(pos):
	position = pos
	$CollisionShape2D.set_deferred("disabled", false)




func _on_body_entered(body):
	if body is PerryDodgeEnemy:
		hit()
	pass # Replace with function body.
