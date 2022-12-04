extends Node2D

export var preview_textures = []
export var player_count = 2

func _process(delta):
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene("res://Menus/PlayerSelect.tscn")

func load_level(name):
	get_tree().change_scene("res://Levels/%s.tscn" % name)

func set_preview_texture(index):
	$Preview.texture = preview_textures[index]
