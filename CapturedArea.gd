extends Area2D

export (Color) var color = Color.red
export (int) var damage = 1

var owner_id = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.color = color
	
func create_shape(polygons):
	$Polygon2D.position = polygons[0]
	$CollisionPolygon2D.position = polygons[0]
		
	var local_polygons = []
	for pos in polygons:
		local_polygons.append($Polygon2D.to_local(pos))
	$Polygon2D.polygon = local_polygons
	$CollisionPolygon2D.polygon = local_polygons
	$AnimationPlayer.play("Implode")

func _on_CapturedArea_body_entered(body):
	if body.has_method("take_damage"):
		if body.id != owner_id:
			body.take_damage()
