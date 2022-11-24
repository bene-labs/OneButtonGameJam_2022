extends Node2D

func _ready():
	randomize()

func restart_after_delay():
	$RestartDelay.start()

func _on_RestartDelay_timeout():
	get_tree().reload_current_scene()
