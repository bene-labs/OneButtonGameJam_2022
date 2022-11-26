extends StaticBody2D

enum Side{
	TOP,
	LEFT,
	BOTTOM,
	RIGHT
}

export (Side) var side = Side.TOP

func get_bounce_angle():
	match side:
		Side.TOP:
			return TAU * 0.25
		Side.RIGHT:
			return TAU * 0.5
		Side.BOTTOM:
			return TAU * 0.75
		Side.LEFT:
			return 0

func get_reflection_velocity(velocity):
		match side:
			Side.TOP:
				return Vector2(velocity.x, -velocity.y)
			Side.RIGHT:
				return Vector2(-velocity.x, velocity.y)
			Side.BOTTOM:
				return Vector2(velocity.x, -velocity.y)
			Side.LEFT:
				return Vector2(-velocity.x, velocity.y)
