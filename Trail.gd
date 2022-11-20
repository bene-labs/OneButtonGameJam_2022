extends Node2D

export (NodePath) var to_follow
export (bool) var activate_create_shape_wip = true
export var fade_time = 5.0 # time in seconds afer a point of the line is removed (set negative for a permanent line)

onready var CapturedArea = preload("res://CapturedArea.tscn")

func _on_Trail_Timer_timeout():
	var points_copy = $Line.points
	points_copy.append(get_node(to_follow).global_position)
	if fade_time > 0 and $Line.points.size() > fade_time / $Timer.wait_time:
		points_copy.remove(0)
	$Line.points = points_copy
	if activate_create_shape_wip:
		var intersections = find_intersections($Line.points)
		if intersections != []:
			create_captured_area_from_intersections(intersections, $Line.points)

func create_captured_area_from_intersections(intersections, points):
	for interscetion in intersections:
		var new_line = [points[-1], points[-2]]
		var polygon : PoolVector2Array = []
		polygon.push_back(interscetion)
		polygon.push_back( points[-2])
		for i in range(points.size() -3, 0, -1):
			if get_segment_intersection(new_line[0], new_line[1], points[i], points[i-1]) != null:
				var new_area = CapturedArea.instance()
				new_area.create_shape(polygon)
				add_child(new_area)
				var newLine = $Line.points
				for j in range(points.size()):
					newLine.remove(-(j+1))
				$Line.points = newLine
				break
			polygon.push_back(points[i])
			
func find_intersections(points):
	var intersections = []

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

			# Calculate intersection of the two segments
			var intersection = get_segment_intersection(begin0, end0, begin1, end1)
			if intersection != null:
				intersections.append(intersection)

	return intersections

static func get_segment_intersection(a, b, c, d):
	# http://paulbourke.net/geometry/pointlineplane/ <-- Good stuff
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
