# An Achor that acts as a target object for the player's hookshoot
#
# If the Hookshot Rope of a player is attached to this object,
# a rotation point will be created to handle the player Rotation.

class_name Anchor

extends StaticBody2D

# Used for Hookshoot collision check.
# Players need to mask this layer so they can connect to this anchor. 
onready var def_layer = collision_layer
var connected_player = null

signal wasHitLoadTutorialScene2

# Effects only affect the player while he is attached to and rotating around the Anchor.
#
# Effects are as follows:
#
# |Name   |Description                                            |Color           |Related Variable (provides 'x' value)                        |
# |-------|-------------------------------------------------------|----------------|-------------------------------------------------------------|
# |Nothing|No Effect                                              |Yellow (default)|None                                                         |
# |Push   |Player will move x units towards the anchor each frame.|Purple          |[pull_strength](RotationPoint.md#pull/_strength)       |
# |Push   |Player will move x away from the anchor each frame.    |Blue            |[push_strength](RotationPoint.md#push/_strength)       |
# |Fast   |Player will move x additional units each frame.        |Green           |[fast_speed_bonus](RotationPoint.md#fast/_speed/_bonus)|
# |Slow   |Player will only move at x times the usual speed.      |Red             |[slow_multiplier](RotationPoint.md#slow/_multiplier)   |
enum Effects{NOTHING,PULL,PUSH,FAST,SLOW}

export (Dictionary) var effect_colors = {Effects.NOTHING:Color.yellow, 
Effects.PULL:Color.purple, Effects.PUSH:Color.blue ,Effects.FAST:Color.green, Effects.SLOW:Color.red}

export (Effects) var effect = Effects.NOTHING
export (bool) var randomize_effect = true

func set_effect(value):
	effect = value
	$Background.color = effect_colors[effect]

func _ready():
	if randomize_effect:
		randomize()
		set_effect(get_random_effect())
	$Background.color = effect_colors[effect]

func get_random_effect():
	var new_effect = randi() % (Effects.values().size())
	return new_effect

func connect_player(player):
	connected_player = player

func disconnect_player():
	connected_player = null
	
func deactivate():
	collision_layer = 0
	if connected_player != null:
		connected_player.get_node("Hookshot").detach()
	$Sprite.modulate.a = 0.2
	$Background.modulate.a = 0.2
	$DeactivationTimer.start()
	emit_signal("wasHitLoadTutorialScene2")

func _on_DeactivationTimer_timeout():
	if randomize_effect:
		set_effect(get_random_effect())
	collision_layer = def_layer
	$Sprite.modulate.a = 1
	$Background.modulate.a = 1
