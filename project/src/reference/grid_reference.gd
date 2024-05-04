@tool
extends CanvasLayer

@export var hide_background = false
@export var show_half : bool : set = set_show_half
@export var show_third : bool  : set = set_show_third
@export var show_fourth : bool  : set = set_show_fourth
@export var show_fifth : bool  : set = set_show_fifth
@export var show_9x16 : bool  : set = set_show_ninesixteen
@export var show_18x32 : bool  : set = set_show_eighteenthirtytwo

# Called when the node enters the scene tree for the first time.
func _ready():
	if hide_background:
		#Background.hide()
		pass
func set_show_half(value):
		show_half = value
		%HalfGrid.visible = value

func set_show_third(value):
		show_third = value
		%ThirdGrid.visible = value

func set_show_fourth(value):
		show_fourth = value
		%FourthGrid.visible = value

func set_show_fifth(value):
		show_fifth = value
		%FifthGrid.visible = value

func set_show_ninesixteen(value):
		show_9x16 = value
		%NineSixteen.visible = value

func set_show_eighteenthirtytwo(value):
		show_18x32 = value
		%EighteenThirtyTwo.visible = value



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
