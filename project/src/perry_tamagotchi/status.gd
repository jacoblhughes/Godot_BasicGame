extends CanvasLayer

signal hunger_satisfy

# Called when the node enters the scene tree for the first time.
func _ready():
	%HungerSatisfy.pressed.connect(_on_hunger_satisfy_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_status(status):

	# Assign the loaded values to the variables
	%Living.text = str(status.get("living", false))
	%HatchTime.text = Time.get_datetime_string_from_unix_time(status.get("hatch_time",  0))
	%Health.value = status.get("health", 100)
	%Hunger.value = status.get("hunger", 100)
	%Happiness.value = status.get("happiness", 100)
	%LastHungerSatisfy.text = Time.get_datetime_string_from_unix_time(status.get("last_hunger_satisfy",  0))
	%LastHungerPenalize.text = Time.get_datetime_string_from_unix_time(status.get("last_hunger_penalize",  0))

func _on_hunger_satisfy_pressed():
	hunger_satisfy.emit()
