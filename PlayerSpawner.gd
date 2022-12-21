class_name PlayerSpawner extends Node2D

export (PackedScene) var player 
export (PackedScene) var trail 
export var spawn_positions = []
var player_count = 2
var player_ids = []

func _ready():
	player_count = Configs.player_count
	randomize()
	spawn_positions.shuffle()
	
	for i in range(player_count):
		var new_trail = trail.instance()
		var new_player = player.instance()
		new_player.id = i + 1
		new_player.global_position = get_node(spawn_positions.pop_front()).global_position
		new_player.name = "Player" + str(new_player.id)
		add_child(new_player)
		player_ids.append(new_player.id)
		new_trail.to_follow = new_player.get_path()
		new_trail.spawn_powerups = true
		new_trail.name = "Player" + str(new_player.id) + "_Trail"
		add_child(new_trail)

func _on_player_death(player_id):
	player_count -= 1
	player_ids.erase(player_id)
	Configs.player_points[player_id - 1] += 4 - player_count
	if player_count == 1 and get_tree().root.get_child(1).has_method("trigger_game_over_after_delay"):
		Configs.player_points[player_ids[0] - 1] = 4
		get_tree().root.get_child(1).trigger_game_over_after_delay(player_ids[0])
