extends Sprite

enum AimMethods{
	CONSTANT_ROTATION,
	AIM_TO_CLOSEST
}

export (AimMethods) var aim_method = AimMethods.CONSTANT_ROTATION
# Called when the node enters the scene tree for the first time.
export var rotation_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	if aim_method == AimMethods.CONSTANT_ROTATION:
		flip_h = true
	else:
		push_warning("Aim Method not yet implemented!")

func _process(delta):
	match aim_method:
		AimMethods.CONSTANT_ROTATION:
			var rotation_point = get_parent().position
			global_position = rotation_point + (global_position - rotation_point).rotated(rotation_speed * delta)
			look_at(rotation_point)
