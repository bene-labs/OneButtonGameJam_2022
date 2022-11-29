extends Node2D

export (NodePath) var to_follow
#export (float) var minmum_point_distance = 1.0
export (bool) var create_shapes = true
export var fade_time = -1.0 # time in seconds afer a point of the line is removed (set negative for a permanent line)
export var debug : bool = false

var intersection_blacklist = []
onready var CapturedArea = preload("res://CapturedArea.tscn")

func _ready():
	if get_node(to_follow).has_method("assign_trail"):
		get_node(to_follow).assign_trail(self)

func set_color(color):
	$Line.default_color = color

func clear_line():
	$Line.clear_points()

func _on_Trail_Timer_timeout():
	var new_point = get_node(to_follow).global_position
#	var points_copy = $Line.points
	$Line.add_point(new_point)
	if fade_time > 0 and $Line.points.size() > fade_time / $Timer.wait_time:
		$Line.remove_point(0)
	if create_shapes:
		var intersection = find_intersection($Line.points)
		if intersection != null:
			create_captured_area_from_intersection(intersection, $Line.points)

func create_captured_area_from_intersection(intersection, points):
	var new_line = [points[-1], points[-2]]
	var polygon : PoolVector2Array = []
	polygon.push_back(intersection)
	for i in range(points.size() -3, 0, -1):
		if get_segment_intersection(new_line[0], new_line[1], points[i], points[i-1]) != null:
			var new_area = CapturedArea.instance()
			get_tree().root.get_child(0).add_child(new_area)
			new_area.create_shape(polygon, $Line.default_color, get_node(to_follow))
			if get_tree().root.get_child(0).get_node("PowerUpSpawner") != null:
				get_tree().root.get_child(0).get_node("PowerUpSpawner").spawn_on_zoned()
			$Line.clear_points()
			break
		polygon.push_back(points[i])
			
func find_intersection(points):
	# Iterate all segments to see if they intersect another.
	# (Start at 1 because it's easier to iterate pairs of points)
	for i in range(1, len(points)):

		# Note: the +1 makes sure we don't get two results per segment pairs
		# (intersection of A into B and intersection of B into A, which are the same anyways)
		for j in range(1 + i, len(points)):
			if abs(j - i) < 2:
				# Ignore self and neighbors
				continue

			var begin0 = points[i - 1]
			var end0 = points[i]

			var begin1 = points[j - 1]
			var end1 = points[j]

#			var test = get_segment_intersection(begin0, end0, begin1, end1)

			var intersection = Geometry.segment_intersects_segment_2d(begin0, end0, begin1, end1)
			if intersection != null:
				return intersection

static func get_segment_intersection(a, b, c, d):
	var cd = d - c
	var ab = b - a
	var div = cd.y * ab.x - cd.x * ab.y

	if abs(div) > 0.001:
		var ua = (cd.x * (a.y - c.y) - cd.y * (a.x - c.x)) / div
		var ub = (ab.x * (a.y - c.y) - ab.y * (a.x - c.x)) / div
		var intersection = a + ua * ab
		if ua >= 0.0 and ua <= 1.0 and ub >= 0.0 and ub <= 1.0:
			return intersection
		return null

	# Segments are parallel!
	return null

func set_line_color(color):
	$Line.default_color = color

func is_polygon_valid(polygon) -> bool: # returns false if the area has a height or width of 0
	var is_straight_line = true
	
	if polygon.size() < 3:
		return false

	var line_vector = polygon[2] - polygon[1]
	if debug:
		print("Line Vector: ", line_vector, "\n#########")
	for i in range(2, polygon.size() - 1, 1):
		if abs(Vector2(polygon[i + 1] - polygon[i]).x) - abs(line_vector.x) >= 1 or \
			abs(Vector2(polygon[i + 1] - polygon[i]).y) - abs(line_vector.y) >= 1:
			is_straight_line = false
			if debug:
				print("NOT LINE VECTOR: ",  Vector2(polygon[i + 1] - polygon[i]), "!")
			break
		
	return (not is_straight_line)
