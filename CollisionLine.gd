extends Line2D

var temp1
var temp2

func _ready():
	generate_collision()
	pass

func generate_collision():
	print(points)
	var pol = $StaticBody2D/CollisionPolygon2D.polygon
	for point in points:
		pol.push_back(Vector2(point.x, point.y - width / 2))
	for i in range(points.size() - 1, 0, -1):
		pol.push_back(Vector2(points[i].x, points[i].y + width / 2))
		#pol.push_back(point)
#	for point in points:
#		pol.push_back(Vector2(point.x - width / 2, point.y))
#	for point in points:
#		pol.push_back(Vector2(point.x + width / 2, point.y))
	
	$StaticBody2D/CollisionPolygon2D.polygon = pol
	print($StaticBody2D/CollisionPolygon2D.polygon)
	
# Called when the node enters the scene tree for the first time.
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
