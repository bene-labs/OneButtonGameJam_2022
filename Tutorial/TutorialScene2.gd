extends Node2D

var collectedPowerUps = 0

export (NodePath) var continueButtonPath
export (NodePath) var playerPath

func _ready():
	get_node(continueButtonPath).hide()
	get_node(continueButtonPath).disabled = true
	get_node(continueButtonPath).get_parent().set_process(false)

func _on_PowerUp_wasCollected():
	collectedPowerUps += 1
	if collectedPowerUps > 2:
		get_node(continueButtonPath).show()
		get_node(continueButtonPath).disabled = false
		get_node(continueButtonPath).get_parent().set_process(true)
		get_node(playerPath).set_physics_process(false)

func loadNextScene():
	get_tree().change_scene("res://Tutorial/TutorialScene3.tscn")
