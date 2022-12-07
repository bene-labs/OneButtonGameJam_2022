extends Node2D

export (NodePath) var continueButtonPath
export (NodePath) var playerPath

func _ready():
	get_node(continueButtonPath).hide()

func loadNextScene():
	get_tree().change_scene("res://Menus/PlayerSelect.tscn")

func _on_PowerUp2_wasCollected():
	get_node(continueButtonPath).show()
	get_node(playerPath).set_process(false)
	get_node(playerPath).set_physics_process(false)
