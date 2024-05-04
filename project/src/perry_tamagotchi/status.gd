extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_status(status):

	# Assign the loaded values to the variables
	%Living.text = str(status.get("living", false))
	%HatchTime.text = str(status.get("hatch_time",  "null"))
	%Health.value = status.get("health", 100)
	%Hunger.value = status.get("hunger", 100)
	%Happiness.value = status.get("happiness", 100)
	%LastHungerSatisfy.text = str(status.get("last_hunger_satisfy",  "null"))
	%LastHungerPenalize.text = str(status.get("last_hunger_penalize",  "null"))
