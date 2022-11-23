extends Node2D

func _on_RestartDelay_timeout():
	get_tree().reload_current_scene()
