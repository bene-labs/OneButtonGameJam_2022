extends Node2D

export var restart_delay = 2.0

func _ready():
	var new_timer = Timer.new()
	new_timer.autostart = false
	new_timer.wait_time = restart_delay
	new_timer.connect("timeout", self, "_on_RestartDelay_timeout")
	new_timer.name = "RestartTimer"
	add_child(new_timer)
	randomize()

func restart_after_delay():
	$RestartTimer.start()

func _on_RestartDelay_timeout():
	get_tree().reload_current_scene()
