extends Node2D

export var player_sprites_paths = []

func preview_selection(selection):
	for sprite in player_sprites_paths:
		get_node(sprite).hide()
	for i in range(int(selection)):
		get_node(player_sprites_paths[i]).show()
		
func confirm_selection(selection):
	Configs.player_count = int(selection)
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
