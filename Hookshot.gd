extends Node2D

export var hookshot_range_multiplier = 3
export (bool) var attach_after_miss = true
export (bool) var debug = false

var hookshot_goal
var connected_obstacle = null
var connection_point
var rope_direction = 0

onready var player = get_parent()
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
	
	$RayCast2D.collision_mask = 4
	$RayCast2D.cast_to = hookshot_goal
	$RayCast2D.force_raycast_update()
	connected_obstacle = $RayCast2D.get_collider()
	if (connected_obstacle != null):
		attach($RayCast2D.get_collision_point())
		return true
	else:
		if attach_after_miss: # add collision to rope to allow later collision
			$Rope/AttachArea/CollisionPolygon2D.polygon = CollisionLine.get_collision_polygons($Rope)
		if debug:
			print("Hookshot missed!")
		return false

func attach(point):
	rotation_point.global_position = connected_obstacle.global_position
	rotation_point.set_simulate_player_position(player.global_position)
	rotation_point.start_rotation()
	rotation_point.calc_and_set_rotation_per_seconds(player.move_speed, player.global_position.distance_to(connected_obstacle.global_position))
	connection_point = point
	rope_direction = $AutoAimer.position.x
	connected_obstacle.connect_player(player)
	if player.has_method("set_reverse_movement"):
		if rope_direction > 0:
			player.set_reverse_movement(false)
		else:
			player.set_reverse_movement(true)
	if debug:
		print("Hookshot hit: ", connected_obstacle.name)
			
func detach():
		$Rope.points = []
		$Rope/AttachArea/CollisionPolygon2D.polygon = []
		if connected_obstacle != null:
			connected_obstacle.disconnect_player()
			connected_obstacle = null
			rotation_point.stop_rotation()

func _on_AttachArea_body_entered(body):
	if connected_obstacle != null:
		return
	if debug:
		print("Hook touched %s after miss!" % body.name) 
	connected_obstacle = body           
	if (connected_obstacle != null):
		attach(body.position)
