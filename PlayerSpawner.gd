extends Node2D

export (PackedScene) var player 
export (PackedScene) var trail 
export var spawn_positions = []
var player_count = 2

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
		new_trail.to_follow = new_player.get_path()
		new_trail.spawn_powerups = true
		new_trail.name = "Player" + str(new_player.id) + "_Trail"
		add_child(new_trail)

func _on_player_death():
	player_count -= 1
	if player_count == 1 and get_tree().root.get_child(1).has_method("restart_after_delay"):
		get_tree().root.get_child(1).restart_after_delay()
