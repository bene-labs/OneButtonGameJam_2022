extends Node2D

export (NodePath) var continueButtonPath
export (NodePath) var playerPath

func _ready():
	get_node(continueButtonPath).hide()

func _on_Enemy_wasHitLoadTutorailScene4():
	get_node(continueButtonPath).show()
	get_node(playerPath).set_process(false)
	get_node(playerPath).set_physics_process(false)

func loadNextScene():
	get_tree().change_scene("res://Tutorial/TutorialScene4.tscn")

