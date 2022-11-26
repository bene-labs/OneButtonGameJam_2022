extends StaticBody2D

enum Side{
	TOP_LEFT,
	TOP_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_RIGHT
}

export (Side) var side = Side.TOP_LEFT

func get_bounce_angle():
	match side:
		Side.TOP_LEFT:
			return 45
		Side.TOP_RIGHT:
			return 135
		Side.BOTTOM_LEFT:
			return 315
		Side.BOTTOM_RIGHT:
			return 225
	

func get_reflection_velocity(velocity):
		match side:
			Side.TOP_LEFT:
				return Vector2(1, 1)
			Side.TOP_RIGHT:
				return Vector2(-1, 1)
			Side.BOTTOM_LEFT:
				return Vector2(1, -1)
			Side.BOTTOM_RIGHT:
				return Vector2(-1, -1)
