extends Node2D

export (PackedScene) var player 
export (PackedScene) var trail 
export var spawn_positions = []
export var player_count = 2

func _ready():
	randomize()
	spawn_positions.shuffle()
	
	for i in range(player_count):
		var new_trail = trail.instance()
		var new_player = player.instance()
		new_player.id = i + 1
		new_player.global_position = get_node(spawn_positions.pop_front()).global_position
		new_player.name = "Player" + str(new_player.id)
		add_child(new_player)
		new_trail.to_follow = new_player.get_path()
		new_trail.name = "Player" + str(new_player.id) + "_Trail"
		add_child(new_trail)
