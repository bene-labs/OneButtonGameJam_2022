extends StaticBody2D

enum Side{
	TOP,
	LEFT,
	BOTTOM,
	RIGHT
}

export (Side) var side = Side.TOP
export var min_bounce_angle = -30
export var max_bounce_angle = 30

func get_bounce_angle():
	var modifier = deg2rad(rand_range(min_bounce_angle, max_bounce_angle))
	match side:
		Side.TOP:
			return TAU * 0.25 + modifier
		Side.RIGHT:
			return TAU * 0.5 + modifier
		Side.BOTTOM:
			return TAU * 0.75 + modifier
		Side.LEFT:
			return 0 + modifier
