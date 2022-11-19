extends Sprite

export var rotation_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	flip_h = true

func _process(delta):
	var rotation_point = get_parent().position
	global_position = rotation_point + (global_position - rotation_point).rotated(rotation_speed * delta)
	look_at(rotation_point)
