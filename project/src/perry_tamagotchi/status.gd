extends CanvasLayer

signal hunger_satisfy

# Called when the node enters the scene tree for the first time.
func _ready():
	%HungerSatisfy.pressed.connect(_on_hunger_satisfy_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%CurrentTime.text = Time.get_datetime_string_from_system(true)
	pass

func set_status(status):
	# Assign the loaded values to the variables
	%Living.text = str(status.get("living", false))
	%HatchTime.text = Time.get_datetime_string_from_datetime_dict(status.get("hatch_time", {}),true)
	%Health.value = status.get("health", 100)
	%Hunger.value = status.get("hunger", 100)
	%Happiness.value = status.get("happiness", 100)
	%LastHungerSatisfy.text = Time.get_datetime_string_from_datetime_dict(status.get("last_hunger_satisfy", {}),true)
	%LastHungerPenalize.text = Time.get_datetime_string_from_datetime_dict(status.get("last_hunger_penalize", {}),true)
	
func _on_hunger_satisfy_pressed():
	hunger_satisfy.emit()
	set_hunger_satisfy_button_disabled(true)

func set_hunger_satisfy_button_disabled(val):
	%HungerSatisfy.disabled = val

func _on_player_finished_eating():
	set_hunger_satisfy_button_disabled(false)
