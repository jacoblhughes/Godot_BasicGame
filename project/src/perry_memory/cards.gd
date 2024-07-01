extends Node2D

@export var matching_card_scene : PackedScene
@export var drawings_png : Texture
@export var card_width : int = 32
@export var card_height : int = 48
signal card_selected(value)
@export var debug : bool
var cards_per_level : Dictionary = {1:4,2:6,3:8,4:10,5:12}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func create_game(level_value):
	var animation_name = "default"
	var texture_width = drawings_png.get_width()
	var texture_height = drawings_png.get_height()

	var cards_horizontal = texture_width / card_width
	#var cards_vertical = texture_height / card_height
	var cards_vertical = cards_per_level[level_value]
	var rows = cards_vertical*2/4
	var cards_per_row = cards_vertical*2/rows
	var viewport_size = get_viewport_rect().size
	var horizontal_spacing = (viewport_size.x - (cards_per_row * card_width)) / (cards_per_row + 1)
	var vertical_spacing = card_height*2  # Adjust as needed for desired vertical spacing
	# Create a list of all possible positions
	var positions = []
	for row in range(rows):
		for col in range(cards_per_row):
			var x = horizontal_spacing * (col + 1) + card_width * col
			var y = (viewport_size.y / 2) + (row - 1) * (card_height + vertical_spacing)
			positions.append(Vector2(x, y))
	positions.shuffle()
	for times in range(2):
		for v in range(cards_vertical):
			var row = int(v / cards_per_row)
			var column = v % cards_per_row

			var x = horizontal_spacing * (column + 1) + card_width * column
			var y = (viewport_size.y / 2) + (row - 1) * (card_height + vertical_spacing)
			var sprite_frames = SpriteFrames.new()
			var matching_card = matching_card_scene.instantiate()
			for h in range(cards_horizontal):
				var texture = AtlasTexture.new()
				texture.atlas = drawings_png
				var region = Rect2(Vector2(h * card_width, v * card_height), Vector2(card_width, card_height))
				texture.region = region
				sprite_frames.add_frame(animation_name, texture,1.0,-1)
				sprite_frames.set_animation_loop(animation_name,false)
				sprite_frames.set_animation_speed(animation_name,30)
			matching_card.drawings_animation.sprite_frames = sprite_frames
			matching_card.position = positions.pop_back()
			matching_card.selection = v
			matching_card.card_selected.connect(func (value) : card_selected.emit(value))
			add_child(matching_card,true)
			if debug:
				matching_card.reveal_card()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
