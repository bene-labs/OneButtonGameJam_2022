extends Node2D


func _on_Anchor_wasHitLoadTutorialScene2():
	get_tree().change_scene("res://Tutorial/TutorialScene2.tscn")
