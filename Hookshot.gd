extends Node2D

export var hookshot_range_multiplier = 3
export (bool) var attach_after_miss = true
export (bool) var debug = false

var hookshot_goal
var connected_obstacle = null
var connection_point
var rope_direction = 0

onready var CollisionLine = preload("res://CollisionLine.gd")

func _ready():
	pass
		
func throw():
	var player = get_parent()
	
	hookshot_goal = ($AutoAimer.global_position - global_position) * hookshot_range_multiplier
	$Rope.points = [Vector2.ZERO, hookshot_goal]
	
	$RayCast2D.cast_to = hookshot_goal
	$RayCast2D.force_raycast_update()
	connected_obstacle = $RayCast2D.get_collider()
	if (connected_obstacle != null):
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
	else:
		if attach_after_miss: # add collision to rope to allow later collision
			$Rope/AttachArea/CollisionPolygon2D.polygon = CollisionLine.get_collision_polygons($Rope)
		if debug:
			print("Hookshot missed!")



func _on_AttachArea_body_entered(body):
	if connected_obstacle != null:
		return
	var player = get_parent()
	
	if debug:
		print("Hook touched!")
	connected_obstacle = body
	if (connected_obstacle != null):
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
