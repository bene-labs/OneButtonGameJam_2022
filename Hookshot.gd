class_name Hookshot extends Node2D

var AnchorEffects = preload("res://Anchor.gd").Effects

var hookshot_range_multiplier = 3
export (bool) var attach_after_miss = true
export (bool) var debug = false

var hookshot_goal
var connected_obstacle = null
var connection_point
var rope_direction = 0

onready var player = get_parent()
onready var CollisionLine = preload("res://CollisionLine.gd")
onready var RotationPoint = preload("res://RotationPoint.tscn")
var rotation_point = null # setget , get_rotation_point
	
export (bool) var swing_towards_indicator = true
export (bool) var rotate_with_indicator = true
export (bool) var disable_indicator_while_rope_attached = false

var is_thrown = false

func _ready():
	$Rope.hide()
	$Rope/AttachArea/CollisionPolygon2D.disabled = true
	rotation_point = RotationPoint.instance()
	rotation_point.name = "RotationPoint-" + get_parent().name
	get_tree().root.get_child(1).call_deferred("add_child", rotation_point)
	set_process(false)

func throw() -> bool:
	$Rope.show()
	set_process(true)
	is_thrown = true
	hookshot_goal = ($AutoAimer.global_position - global_position) * hookshot_range_multiplier
#	if rotate_with_indicator:
#		$Rope.points = [$AutoAimer.position, hookshot_goal]
#	else:
#	$Rope.points = [Vector2.ZERO, hookshot_goal]
	
	
	$RayCast2D.collision_mask = 4
	$RayCast2D.cast_to = hookshot_goal
	$RayCast2D.force_raycast_update()
	connected_obstacle = $RayCast2D.get_collider()
	if (connected_obstacle != null):
		attach($RayCast2D.get_collision_point())
		return true
	else:
		if attach_after_miss:
			$Rope/AttachArea/CollisionPolygon2D.disabled = false
			var rope_poly = $Rope.polygon
			var distance =  abs(position.distance_to(hookshot_goal))
			rope_poly[2].x = distance
			rope_poly[3].x = distance
			$Rope.polygon = rope_poly
			$Rope/AttachArea/CollisionPolygon2D.polygon = $Rope.polygon
			$Rope.rotation = $AutoAimer.rotation + TAU * 0.5
			
#			$Rope/AttachArea/CollisionPolygon2D.polygon = CollisionLine.get_collision_polygons($Rope)
		if debug:
			print("Hookshot missed!")
		return false

func _process(delta):
#	if is_thrown and rotate_with_indicator:
#		$Rope.points = [$AutoAimer.position, ($AutoAimer.global_position - global_position) * hookshot_range_multiplier]
	if connected_obstacle != null:
		if connected_obstacle.effect != AnchorEffects.FAST or connected_obstacle.effect != AnchorEffects.SLOW:
			$Rope.look_at(connected_obstacle.position)
			var rope_poly = $Rope.polygon
			var distance = abs(global_position.distance_to(connected_obstacle.global_position))
			rope_poly[2].x = distance
			rope_poly[3].x = distance
			$Rope.polygon = rope_poly
	elif rotate_with_indicator:
		$Rope.rotation = $AutoAimer.rotation + TAU * 0.5
	
func attach(point):
	var rope_poly = $Rope.polygon
	var distance = abs(global_position.distance_to(connected_obstacle.global_position))
	rope_poly[2].x = distance
	rope_poly[3].x = distance
	$Rope.polygon = rope_poly
	if disable_indicator_while_rope_attached:
		$AutoAimer.stop_spin()
		$AutoAimer.hide()
	is_thrown = false
	rotation_point.global_position = connected_obstacle.global_position
	rotation_point.trigger_effect(connected_obstacle.effect)
	rotation_point.set_simulate_player_position(player.global_position)
	rotation_point.start_rotation()
	rotation_point.calc_and_set_rotation_per_seconds(player.move_speed, player.global_position.distance_to(connected_obstacle.global_position))
	connection_point = point
	rope_direction = $AutoAimer.position.x > 0 if swing_towards_indicator else player.reverse_movement
	connected_obstacle.connect_player(player)
	if player.has_method("set_reverse_movement"):
		player.set_reverse_movement(rope_direction)
	if debug:
		print("Hookshot hit: ", connected_obstacle.name)
			
func detach():
	$AutoAimer.start_constant_spin()
	$AutoAimer.show()
	$Rope.rotation = 0
	$Rope.hide()
	call_deferred("set_collision_enabled", true)
#	$Rope/AttachArea/CollisionPolygon2D.polygon = []
	rotation_point.reset()
	if connected_obstacle != null:
		connected_obstacle.disconnect_player()
		connected_obstacle = null
		rotation_point.stop_rotation()

func set_collision_enabled(state):
	$Rope/AttachArea/CollisionPolygon2D.disabled = state

func _on_AttachArea_body_entered(body):
	if connected_obstacle != null:
		return
	if debug:
		print("Hook touched %s after miss!" % body.name) 
	connected_obstacle = body
	if (connected_obstacle != null):
		attach(body.position)
