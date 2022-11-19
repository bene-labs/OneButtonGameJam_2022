extends KinematicBody2D

export var hookshot_range_multiplier = 3
export var move_speed = 0.75
export (bool) var bounce_of_obstacles = true

var hookshot_goal
var connected_obstacle = null
var connection_point

var reverse_movement = false # false = right, true = left

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func throw_hook_shoot():
	hookshot_goal = ($AutoAimer.global_position - global_position) * hookshot_range_multiplier
	# print("Hookshot cast to: ", hookshot_goal)
	# print("line is from", global_position, " to ", hookshot_goal)
	$HookshotLine.points = [Vector2.ZERO, hookshot_goal]
	
	$RayCast2D.cast_to = hookshot_goal
	$RayCast2D.force_raycast_update()
	connected_obstacle = $RayCast2D.get_collider()
	if (connected_obstacle != null):
		connection_point = $RayCast2D.get_collision_point()
#		if position.y > connection_point.y and position.x < connected_obstacle.position.x or \
#			position.y < connected_obstacle.position.y and position.x > connected_obstacle.position.x:
#			reverse_movement = !reverse_movement
		if $AutoAimer.position.x > 0:
			reverse_movement = false
		else:
			reverse_movement = true
		print("Hookshot hit: ", connected_obstacle.name)
	else:
		print("Hookshot missed!")
#	var space_state = get_world_2d().direct_space_state
#	var result = space_state.intersect_ray(position, hookshot_goal)
#	if !result.empty():
#		print("Hook hit:", result)
	
	
func _process(delta):
	if Input.is_action_just_pressed("action"):
		throw_hook_shoot()
	elif Input.is_action_just_released("action"):
		$HookshotLine.points = []
		connected_obstacle = null
		
	# DEBUG
	if Input.is_action_just_pressed("debug_increase_move_speed"):
		move_speed += 1
	if Input.is_action_just_pressed("debug_reduce_move_speed"):
		if move_speed > 0:
			move_speed -= 1

func _physics_process(delta):
	var velocity = Vector2(move_speed * (-1 if reverse_movement else 1), 0).rotated($Sprite.rotation)
	
	if connected_obstacle != null:
		$Sprite.rotation = get_angle_to(connected_obstacle.position) + TAU * 0.25
		$HookshotLine.points = [Vector2(0, 0), to_local(connected_obstacle.position)]
		$CollisionShape2D.rotation = $Sprite.rotation
	move_and_collide(velocity)


func _on_BounceArea_body_entered(body):
	if bounce_of_obstacles:
		reverse_movement = !reverse_movement
