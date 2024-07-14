extends Area2D

const SPEED = 300.0

func _ready():
	self.body_entered.connect(_on_body_entered)
	pass

func _physics_process(delta):
	position.x -= SPEED * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.hit()
	pass
