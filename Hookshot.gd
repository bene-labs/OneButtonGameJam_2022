extends Node2D

export var hookshot_range_multiplier = 3
export (bool) var attach_after_miss = true
export (bool) var debug = false

var hookshot_goal
var connected_obstacle = null
var connection_point
var rope_direction = 0

var player = get_parent()
onready var CollisionLine = preload("res://CollisionLine.gd")
var rotation_point = null # setget , get_rotation_point
	
#func get_rotation_point():
#	 return get_tree().root.get_child(0).get_node("RotationPoint-" + get_parent().name)

func _ready():
	rotation_point = preload("res://RotationPoint.tscn").instance()
	rotation_point.name = "RotationPoint-" + get_parent().name
	get_tree().root.get_child(0).call_deferred("add_child", rotation_point)

func throw() -> bool:
	hookshot_goal = ($AutoAimer.global_position - global_position) * hookshot_range_multiplier
	$Rope.points = [Vector2.ZERO, hookshot_goal]
	
	$RayCast2D.cast_to = hookshot_goal
	$RayCast2D.force_raycast_update()
	connected_obstacle = $RayCast2D.get_collider()
	if (connected_obstacle != null):
		rotation_point.global_position = connected_obstacle.global_position
		rotation_point.get_node("SimulatedPlayerPosition").global_position = player.global_position
		rotation_point.calc_and_set_rotation_per_seconds(player.move_speed, player.global_position.distance_to(connected_obstacle.global_position))
		rotation_point.start_rotation()
		connection_point = $RayCast2D.get_collision_point()
#		if position.y > connection_point.y and position.x < connected_obstacle.position.x or \
#			position.y < connected_obstacle.position.y and position.x > connected_obstacle.position.x:
#			reverse_movement = !reverse_movement
		rope_direction = $AutoAimer.position.x
		if player.has_method("set_reverse_movement"):
			if rope_direction > 0:
				player.set_reverse_movement(false)
			else:
				player.set_reverse_movement(true)
		if debug:
			print("Hookshot hit: ", connected_obstacle.name)
		return true
	else:
		if attach_after_miss: # add collision to rope to allow later collision
			$Rope/AttachArea/CollisionPolygon2D.polygon = CollisionLine.get_collision_polygons($Rope)
		if debug:
			print("Hookshot missed!")
		return false

func _on_AttachArea_body_entered(body):
	if connected_obstacle != null:
		return
	var player = get_parent()
	
	if debug:
		print("Hook touched!")
	connected_obstacle = body
	if (connected_obstacle != null):
		rotation_point.global_position = connected_obstacle.global_position
		rotation_point.get_node("SimulatedPlayerPosition").global_position = player.global_position
		rotation_point.start_rotation()
		rotation_point.calc_and_set_rotation_per_seconds(player.move_speed, player.global_position.distance_to(connected_obstacle.global_position))
		connection_point = body.position
#		if position.y > connection_point.y and position.x < connected_obstacle.position.x or \
#			position.y < connected_obstacle.position.y and position.x > connected_obstacle.position.x:
#			reverse_movement = !reverse_movement
		if player.has_method("set_reverse_movement"):
			if rope_direction > 0:
				player.set_reverse_movement(false)
			else:
				player.set_reverse_movement(true)
		if debug:
			print("Hookshot hit after miss: ", connected_obstacle.name)
