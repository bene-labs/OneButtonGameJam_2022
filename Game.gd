extends Node2D

export var restart_delay = 2.0
export (bool) var switch_level_on_restart = false
export var levels = []

func _ready():
	$FpsCounter.hide()
	var new_timer = Timer.new()
	new_timer.autostart = false
	new_timer.wait_time = restart_delay
	new_timer.connect("timeout", self, "_on_RestartDelay_timeout")
	new_timer.name = "RestartTimer"
	add_child(new_timer)
	randomize()

func _input(event):
	if Input.is_action_just_pressed("toogle_fps"):
		$FpsCounter.hide() if $FpsCounter.is_visible() else $FpsCounter.show()

func restart_after_delay():
	$RestartTimer.start()

func _on_RestartDelay_timeout():
	if switch_level_on_restart:
		get_tree().change_scene(levels[randi() % levels.size()])
	else:
		get_tree().reload_current_scene()
