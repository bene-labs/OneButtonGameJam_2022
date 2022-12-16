extends Node2D

func _ready():
	update_text()

func update_text():
	$Torunament_Points.text = "Player1: %d\nPlayer2: %d\nPlayer3: %d\nPlayer4: %d" % Configs.player_points

func _process(delta):
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene("res://Menus/PlayerSelect.tscn")

func reset():
	for i in range(len(Configs.player_points)):
		Configs.player_points[i] = 0
	update_text()

func load_next():
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
