extends Node2D

export var preview_textures = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_level(name):
	get_tree().change_scene("res://Levels/%s.tscn" % name)

func set_preview_texture(index):
	$Preview.texture = preview_textures[index]
