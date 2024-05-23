extends CanvasLayer

signal hunger_satisfy
signal happiness_satisfy
# Called when the node enters the scene tree for the first time.
func _ready():
	%HungerSatisfy.pressed.connect(_on_hunger_satisfy_pressed)
	%HappinessSatisfy.pressed.connect(_on_happiness_satisfy_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%CurrentTime.text = Time.get_datetime_string_from_system(true)
	pass

func set_status(status):
	var current_living_status = status.get("living", false)
	if current_living_status:
		%Living.text = str(status.get("living", false))
		var time_with_offset = Time.get_unix_time_from_datetime_dict(status.get("hatch_time", {})) + (Time.get_time_zone_from_system()['bias']*60)
		%HatchTime.text = format_birth_date_from_unix(time_with_offset)
		#Time.get_datetime_string_from_datetime_dict(status.get("hatch_time", {}),true)
		%Health.value = status.get("health", 100)
		%Hunger.value = status.get("hunger", 100)
		%Happiness.value = status.get("happiness", 100)
		%LastHungerSatisfy.text = Time.get_datetime_string_from_datetime_dict(status.get("last_hunger_satisfy", {}),true)
		%LastHungerPenalize.text = Time.get_datetime_string_from_datetime_dict(status.get("last_health_satisfy", {}),true)
		%LastHappinessSatisfy.text = Time.get_datetime_string_from_datetime_dict(status.get("last_happiness_satisfy", {}),true)
	else:
		%Living.text = str(status.get("living", false))
		%HatchTime.text = str(status.get("hatch_time", {}))
		%Health.value = status.get("health", 100)
		%Hunger.value = status.get("hunger", 100)
		%Happiness.value = status.get("happiness", 100)
		%LastHungerSatisfy.text = str(status.get("last_hunger_satisfy", {}))
		%LastHungerPenalize.text = str(status.get("last_health_satisfy", {}))
		%LastHappinessSatisfy.text =str(status.get("last_happiness_satisfy", {}))
	# Assign the loaded values to the variables

func _on_hunger_satisfy_pressed():
	hunger_satisfy.emit()
	set_action_buttons_disabled(true)

func _on_happiness_satisfy_pressed():
	happiness_satisfy.emit()
	set_action_buttons_disabled(true)

func _on_player_finished_eating():
	set_action_buttons_disabled(false)

func set_action_buttons_disabled(val):
	%HungerSatisfy.disabled = val
	%HappinessSatisfy.disabled = val

func _on_player_finished_playing():
	set_action_buttons_disabled(false)


func format_birth_date_from_unix(unix_time_val: int) -> String:
	var datetime_dict = Time.get_datetime_dict_from_unix_time(unix_time_val)
	
	var formatted_string = "Birth Day: %02d %02d %d at %02d %02d %02d" % [
		datetime_dict["month"],
		datetime_dict["day"],
		datetime_dict["year"],
		datetime_dict["hour"],
		datetime_dict["minute"],
		datetime_dict["second"]
	]
	
	return formatted_string
