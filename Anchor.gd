extends StaticBody2D

onready var def_layer = collision_layer
var connected_player = null

func connect_player(player):
	connected_player = player

func disconnect_player():
	connected_player = null

func deactivate():
	collision_layer = 0
	if connected_player != null:
		connected_player.get_node("Hookshot").detach()
	$DeactivationTimer.start()
	$Sprite.hide()

func _on_DeactivationTimer_timeout():
	collision_layer = def_layer
	$Sprite.show()
