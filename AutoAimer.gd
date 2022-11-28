extends Sprite

enum AimMethods{
	CONSTANT_ROTATION,
	TARGET_OBSTACLE
}

export (AimMethods) var aim_method = AimMethods.CONSTANT_ROTATION
# Called when the node enters the scene tree for the first time.
export var rotation_speed = 5
# Called when the node enters the scene tree for the first time.
var targeted_obstacle = null
var enable_rotating = true

func stop_spin():
	enable_rotating = false
	
func start_constant_spin():
	aim_method = AimMethods.CONSTANT_ROTATION
	targeted_obstacle = null
	flip_h = true
	enable_rotating = true

func target_obstacle(obstacle):
	aim_method = AimMethods.TARGET_OBSTACLE
	targeted_obstacle = obstacle
	flip_h = false

func _ready():
	if aim_method == AimMethods.CONSTANT_ROTATION:
		flip_h = true
	else:
		push_warning("Aim Method not yet implemented!")

func _process(delta):
	match aim_method:
		AimMethods.CONSTANT_ROTATION:
			if not enable_rotating:
				return
			var rotation_point = get_parent().global_position
			global_position = rotation_point + (global_position - rotation_point).rotated(rotation_speed * delta)
			look_at(rotation_point)
		AimMethods.TARGET_OBSTACLE:
			look_at(targeted_obstacle.global_position)
