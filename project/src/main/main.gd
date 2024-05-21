extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	HUD.hide()
	GameStartGameOver.hide()
	Background.hide()
	print(Time.get_datetime_dict_from_system())
	print(Time.get_datetime_string_from_system())
	search_scenes()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed('pc_reset'):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("pc_quit"):
		get_tree().quit()

# This script searches through all the scenes in the project to find those containing AudioStreamPlayer nodes.

# Function to recursively search for AudioStreamPlayer nodes in a scene tree
#func find_audio_stream_nodes(scene_path, node, result):
	#if node is AudioStreamPlayer:
		#result.append(scene_path)
	#for child in node.get_children():
		#find_audio_stream_nodes(scene_path, child, result)
#
## Recursive function to traverse directories and search for scenes
#func traverse_directory(path, result):
	#var dir_access = DirAccess.open(path)
#
	#if dir_access:
		#dir_access.list_dir_begin()
		#var file_name = dir_access.get_next()
#
		#while file_name != "":
			#if file_name != "." and file_name != "..":
				#var file_path = path.path_join(file_name)
				#if dir_access.current_is_dir():
					## Recursively traverse subdirectories
					#traverse_directory(file_path, result)
				#else:
					#if file_name.ends_with(".tscn") or file_name.ends_with(".scn"):
						#var scene = load(file_path)
						#if scene:
							#var instance = scene.instantiate()
							#if instance:
								#find_audio_stream_nodes(file_path, instance, result)
			#file_name = dir_access.get_next()
		#dir_access.list_dir_end()
	#else:
		#print("Error opening directory:", path)
#
## Function to search for scenes containing AudioStreamPlayer nodes
#func search_scenes():
	#var scenes_with_audio = []
	#traverse_directory("res://src/", scenes_with_audio)
	#print("Scenes containing AudioStreamPlayer nodes:", scenes_with_audio)

# Function to recursively search for Node2D nodes in a scene tree and print their scale transform value
func find_scale_transform_nodes(scene_path, node):
	if node is Node2D and node.scale != Vector2(1, 1):
		print("Scene:", scene_path, "Node:", node.name, "Scale:", node.scale)
	for child in node.get_children():
		find_scale_transform_nodes(scene_path, child)

# Recursive function to traverse directories and search for scenes
func traverse_directory(path, result):
	var dir_access = DirAccess.open(path)

	if dir_access:
		dir_access.list_dir_begin()
		var file_name = dir_access.get_next()

		while file_name != "":
			if file_name != "." and file_name != "..":
				var file_path = path.path_join(file_name)
				if dir_access.current_is_dir():
					# Recursively traverse subdirectories
					traverse_directory(file_path, result)
				else:
					if file_name.ends_with(".tscn") or file_name.ends_with(".scn"):
						var scene = load(file_path)
						if scene:
							var instance = scene.instantiate()
							if instance:
								find_scale_transform_nodes(file_path, instance)
			file_name = dir_access.get_next()
		dir_access.list_dir_end()
	else:
		print("Error opening directory:", path)

# Function to search for scenes containing Node2D nodes and print their scale transform value
func search_scenes():
	var scenes_with_scale = []
	traverse_directory("res://src/", scenes_with_scale)
	print("Search complete.")
