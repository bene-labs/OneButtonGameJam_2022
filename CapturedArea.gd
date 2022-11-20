extends Area2D

export (Color) var color = Color.red

# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.color = color
	
func create_shape(polygons):
	$Polygon2D.polygon = polygons
	$CollisionPolygon2D.polygon = polygons
