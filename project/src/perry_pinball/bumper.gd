extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("ball"):
		%AnimatedSprite2D.play("hit")
		var direction = (body.global_position - global_position).normalized()
		var bounce_strength = 1000  # Customize this value based on desired bounce strength
		body.linear_velocity = direction * bounce_strength
		await get_tree().create_timer(.5).timeout
		%AnimatedSprite2D.play("default")
