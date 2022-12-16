class_name Game extends Node2D

export var game_over_delay = 2.0
export (bool) var load_random_level_on_restart = false
export var levels = []

func _ready():
	$FpsCounter.hide()
	var new_timer = Timer.new()
	new_timer.autostart = false
	new_timer.wait_time = game_over_delay
	new_timer.connect("timeout", self, "_on_GameOverDelay_timeout")
	new_timer.name = "GameOverTimer"
	add_child(new_timer)
	randomize()

func _input(event):
	if Input.is_action_just_pressed("toogle_fps"):
		$FpsCounter.hide() if $FpsCounter.is_visible() else $FpsCounter.show()
	if event.is_action_pressed("debug_reduce_move_speed"):
		get_tree().change_scene(levels[randi() % levels.size()])
	if event.is_action_pressed("back"):
		get_tree().change_scene("res://Menus/LevelSelect.tscn")

func trigger_game_over_after_delay(winner = 1):
	$VictoryScreen.show()
	$VictoryScreen/Label.text = "Player %d wins!" % winner
	$GameOverTimer.start()

func _on_GameOverDelay_timeout():
	if load_random_level_on_restart:
		get_tree().change_scene(levels[randi() % levels.size()])
	else:
		get_tree().change_scene("res://Menus/LevelSelect.tscn")
