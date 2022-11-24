extends Node2D

export var rotation_per_seconds = 1
export var is_rotating = false
export var x_direction = 1 # 1 or -1
export var move_speed_multiplier = 1.0
export var outward_motion = 0.0

func _process(delta):
	if is_rotating:
		rotate((TAU * rotation_per_seconds) * delta * x_direction)
		if abs(outward_motion) >= 0.01:
			$SimulatedPlayerPosition.position.x += outward_motion * delta
			if $SimulatedPlayerPosition.position.x < 0:
				$SimulatedPlayerPosition.position.x = 0
	
func calc_and_set_rotation_per_seconds(speed, radius):
	speed = speed * move_speed_multiplier
	var circumference = 2 * radius* PI
	rotation_per_seconds = speed / circumference

func start_rotation():
	is_rotating = true
	
func stop_rotation():
	is_rotating = false

func set_x_direction(is_right: bool):
	x_direction = 1 if is_right else -1

func set_simulate_player_position(position):
	$SimulatedPlayerPosition.global_position = position
