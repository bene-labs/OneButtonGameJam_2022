class_name CollisionLine extends Line2D

var temp1
var temp2

func _ready():
	$StaticBody2D/CollisionPolygon2D.polygon = get_collision_polygons(self)
	print($StaticBody2D/CollisionPolygon2D.polygon)

static func get_collision_polygons(line: Line2D) -> PoolVector2Array:
	var pol : PoolVector2Array = []
	
	for point in line.points:
		pol.push_back(Vector2(point.x - line.width / 10, point.y - line.width / 2))
	for i in range(line.points.size() - 1, 0, -1):
		pol.push_back(Vector2(line.points[i].x + line.width / 10, line.points[i].y + line.width / 2))
	return pol
	
	
# from a tutorial... does not seem to work
func generate_collision_tutorial():
	var line_poly = Geometry.offset_polygon_2d(points, width / 2)
	
	print(points)
	# offset_polyline_2d can potenially return multiple polygons
	# so iterate through all polygons and create collision shapes from them
	for poly in line_poly:
		print("############")
		print(poly)
		var col = CollisionPolygon2D.new()
		col.polygon = poly
		$StaticBody2D.add_child(col)
