extends Node2D

onready var Effects = preload("res://Anchor.gd").Effects

export var rotation_per_seconds = 1
export var is_rotating = false
export var x_direction = 1 # 1 or -1
export var move_speed_multiplier = 1.0
export var outward_motion = 0.0

var default_values = {}

func _ready():
	default_values = {"rotation_per_seconds": rotation_per_seconds, \
	"is_rotating": is_rotating, "x_direction": x_direction, \
	"move_speed_multiplier": move_speed_multiplier, "outward_motion": outward_motion}
	
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
	if circumference == 0:
		return
	rotation_per_seconds = speed / circumference

func start_rotation():
	is_rotating = true
	
func stop_rotation():
	is_rotating = false

func set_x_direction(is_right: bool):
	x_direction = 1 if is_right else -1

func set_simulate_player_position(position):
	$SimulatedPlayerPosition.position = Vector2.ZERO
	$SimulatedPlayerPosition.global_position = position

func reset():
	rotation_per_seconds = default_values["rotation_per_seconds"]
	is_rotating = default_values["is_rotating"]
	x_direction = default_values["x_direction"]
	move_speed_multiplier = default_values["move_speed_multiplier"]
	outward_motion = default_values["outward_motion"]

func trigger_effect(effect):
	match effect:
		Effects.FAST:
			move_speed_multiplier += 0.75
		Effects.SLOW:
			move_speed_multiplier /= 2
		Effects.PULL:
			outward_motion = -40
		Effects.PUSH:
			outward_motion = 20
		_:
			pass
