class_name LevelSelect extends Node2D

export var preview_textures = []
export var player_count = 2

export var level_names = []

func _ready():
	randomize()

func _process(delta):
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene("res://TournamentPoints.tscn")

func load_level(name):
	if name == "random":
		get_tree().change_scene("res://Levels/%s.tscn" % level_names[randi() % len(level_names)])
	else:
		get_tree().change_scene("res://Levels/%s.tscn" % name)

func set_preview_texture(index):
	$Preview.texture = preview_textures[index]
