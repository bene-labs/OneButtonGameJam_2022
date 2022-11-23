extends KinematicBody2D

export var hookshot_range_multiplier = 3
export var move_speed = 200
export (bool) var bounce_of_obstacles = true
export (bool) var detach_hookshot_on_bounce = true
export var minimum_bounce_angle = -30
export var maximum_bounce_angle = 30


var reverse_movement = false # false = right, true = left
var swing_start_point = null

var velocity = Vector2.ZERO

func _ready():
	randomize()

func _process(delta):
	if Input.is_action_just_pressed("action"):
		$Hookshot.throw()
	elif Input.is_action_just_released("action"):
		$Hookshot.detach()
		
	# DEBUG
	if Input.is_action_just_pressed("debug_increase_move_speed"):
		move_speed += 1
	if Input.is_action_just_pressed("debug_reduce_move_speed"):
		if move_speed > 0:
			move_speed -= 1

func _physics_process(delta):
	if $Hookshot.connected_obstacle != null:
		$Sprite.rotation = get_angle_to($Hookshot.connected_obstacle.position) + TAU * 0.25
		$Hookshot/Rope.points = [Vector2(0, 0), to_local($Hookshot.connected_obstacle.position)]
		$CollisionShape2D.rotation = $Sprite.rotation
#		global_position =  $Hookshot.rotation_point.get_node("SimulatedPlayerPosition").global_position
		velocity = $Hookshot.rotation_point.get_node("SimulatedPlayerPosition").global_position - global_position
	else:
		velocity = Vector2((-1 if reverse_movement else 1) * move_speed * delta, 0).rotated($Sprite.rotation)
	move_and_collide(velocity)

func set_reverse_movement(new_reverse_movement):
	reverse_movement = new_reverse_movement
	$Hookshot.rotation_point.set_x_direction(reverse_movement)

func revert_movement():
	reverse_movement = !reverse_movement
	$Hookshot.rotation_point.set_x_direction(reverse_movement)

func _on_BounceArea_body_entered(body):
	if bounce_of_obstacles:
		$Hookshot.detach()
		$Sprite.rotation += deg2rad(rand_range(minimum_bounce_angle, maximum_bounce_angle))
		revert_movement()
