@tool
extends CanvasLayer

@export var hide_background = false
@export var show_half : bool : set = set_show_half
@export var show_third : bool  : set = set_show_third
@export var show_fourth : bool  : set = set_show_fourth
@export var show_fifth : bool  : set = set_show_fifth
@export var show_sixth : bool : set = set_show_sixth
@export var show_9x16 : bool  : set = set_show_ninesixteen
@export var show_18x32 : bool  : set = set_show_eighteenthirtytwo
var xform
var yform

# Called when the node enters the scene tree for the first time.
func _ready():
	xform = get_viewport().size.x
	yform = get_viewport().size.y
	print(xform,"  ",yform)
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

func set_show_sixth(value):
		show_sixth = value
		%SixthGrid.visible = value


func set_show_ninesixteen(value):
		show_9x16 = value
		%NineSixteen.visible = value

func set_show_eighteenthirtytwo(value):
		show_18x32 = value
		%EighteenThirtyTwo.visible = value



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
