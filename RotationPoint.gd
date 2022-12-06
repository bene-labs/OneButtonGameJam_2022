extends Node2D

# Resposible for rotating the player around acnhors while using the hookshot.
#
# > For more information on the [Effects](#Effect modifiers) consult the [Anchor Documentation](../Anchor.gd.md)
class_name RotationPoint

# Direct Reference to [Anchor Effects](Anchor.gd.md#Effects)
#
onready var Effects = preload("res://Anchor.gd").Effects ## General Configurations (Configured ingame!)

export var rotation_per_seconds = 1 # determines speed (independent of distance)
export var is_rotating = false # set true to pause rotation
export var x_direction = 1  # Clockwise/Counterclockwise = 1/-1
# used for fast/slow effect
export var move_speed_multiplier = 1.0
# used for pull/push effect
#
export var outward_motion = 0.0 ## Effect modifiers

export var pull_strength = 10 # How fast the player should move towards the anchor.
export var push_strength = 10 # How fast the player should move away from the anchor.
export var slow_multiplier = 0.75 # Move speed is multiplied by this while attached to a slowing Anchor.
# This is added to your move speed while attached to fast Anchor.
#
export var fast_speed_bonus = 2 ## Internal Usage

var default_values = {} # used to restore default

func _ready():
	default_values = {"rotation_per_seconds": rotation_per_seconds, \
	"is_rotating": is_rotating, "x_direction": x_direction, \
	"move_speed_multiplier": move_speed_multiplier, "outward_motion": outward_motion}
	
func _process(delta):
	if is_rotating:
		rotate((TAU * rotation_per_seconds) * delta * x_direction)
		if abs(outward_motion) >= 0.01:
			$SimulatedPlayerPosition.look_at(position)
			var velocity = Vector2(outward_motion * delta, 0).rotated($SimulatedPlayerPosition.rotation)
			$SimulatedPlayerPosition.position += velocity
	
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
	rotation_degrees = 0
	position = Vector2.ZERO
	$SimulatedPlayerPosition.position = Vector2.ZERO
	$SimulatedPlayerPosition.rotation_degrees = 0

func trigger_effect(effect):
	match effect:
		Effects.FAST:
			move_speed_multiplier += fast_speed_bonus
		Effects.SLOW:
			move_speed_multiplier /= slow_multiplier
		Effects.PULL:
			outward_motion = pull_strength
		Effects.PUSH:
			outward_motion -= push_strength
		_:
			pass
