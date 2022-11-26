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
#
func get_reflection_vector(angle_of_incidence:Vector2) -> Vector2:
	match side:
		Side.TOP:
			return angle_of_incidence.reflect(Vector2(1, -1))
		Side.BOTTOM:
			return angle_of_incidence.reflect(Vector2(1, 1))
		Side.RIGHT:
			return angle_of_incidence.reflect(Vector2(-1, 1))
		Side.LEFT:
			return angle_of_incidence.reflect(Vector2(1, 1))
		_:
			return Vector2.ZERO
