extends StaticBody2D

onready var def_layer = collision_layer
var connected_player = null

enum Effects{NOTHING,PULL,PUSH,FAST,SLOW}

export (Dictionary) var effect_colors = {Effects.NOTHING:Color.yellow, 
Effects.PULL:Color.purple, Effects.PUSH:Color.blue ,Effects.FAST:Color.green, Effects.SLOW:Color.red}

export (Effects) var effect = Effects.NOTHING # setget set_effect
export (bool) var randomize_effect = true

func set_effect(value):
	effect = value
	$Background.color = effect_colors[effect]
	#$EffectSpritePlacholder.text = Effects.keys()[effect]

func _ready():
	if randomize_effect:
		randomize()
		set_effect(get_random_effect())
	$Background.color = effect_colors[effect]
	#$EffectSpritePlacholder.text = Effects.keys()[effect]

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
		get_tree().root.get_child(0).get_node("PowerUpSpawner").spawn_if_lucky()
		connected_player.get_node("Hookshot").detach()
	$Sprite.modulate.a = 0.2
	$Background.modulate.a = 0.2
	$DeactivationTimer.start()
	

func _on_DeactivationTimer_timeout():
	if randomize_effect:
		set_effect(get_random_effect())
	collision_layer = def_layer
	$Sprite.modulate.a = 1
	$Background.modulate.a = 1
