extends Node2D

export (NodePath) var continueButtonPath
export (NodePath) var playerPath
export (NodePath) var enemyPath

func _ready():
	get_node(enemyPath).set_process(false)
	get_node(continueButtonPath).hide()
	get_node(continueButtonPath).disabled = true
	get_node(continueButtonPath).get_parent().set_process(false)

func _on_Enemy_died():
		get_node(continueButtonPath).show()
		get_node(continueButtonPath).disabled = false
		get_node(continueButtonPath).get_parent().set_process(true)
		get_node(playerPath).set_physics_process(false)

func loadNextScene():
	get_tree().change_scene("res://Tutorial/TutorialScene4.tscn")

