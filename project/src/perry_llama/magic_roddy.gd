extends Node2D
var animation_player: AnimatedSprite2D
var particles : GPUParticles2D
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = $AnimatedSprite2D
	particles = $GPUParticles2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawn_timer_timeout():
	animation_player.play("appear")
	particles.emitting = true
	await get_tree().create_timer(.5).timeout
	animation_player.play("waving")
	particles.emitting = false
	pass # Replace with function body.
