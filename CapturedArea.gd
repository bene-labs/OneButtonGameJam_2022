class_name CapturedArea extends Area2D

export (Color) var color = Color.red
export (int) var damage = 1
export (bool) var debug = false

var owned_by = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.color = color
	
func create_shape(polygons, new_color, player):
	owned_by = player
	$Polygon2D.position = polygons[0]
	$CollisionPolygon2D.position = polygons[0]
		
	var local_polygons = []
	for pos in polygons:
		local_polygons.append($Polygon2D.to_local(pos))
	$Polygon2D.polygon = local_polygons
	$Polygon2D.color = new_color
	$CollisionPolygon2D.polygon = local_polygons
	$AnimationPlayer.play("Implode")

func _on_CapturedArea_body_entered(body):
	if body == null:
		return
	if debug:
		print("Object zoned: ", body.name)
	if body.has_method("take_damage"):
		if body.id != owned_by.id:
			body.take_damage()
	if body.has_method("deactivate"):
		body.deactivate()
	if body.has_method("use"):
		body.use(owned_by)
