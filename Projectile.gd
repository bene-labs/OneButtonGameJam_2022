class_name Projectile extends Area2D

export var move_speed = 300
export var damage = 1
var creator = null

func _process(delta):
	var velocity = Vector2(move_speed * delta, 0).rotated($Sprite.rotation)
	position += velocity


func _on_Projectile_body_entered(body):
	if body.has_method("take_damage") and body != creator:
		body.take_damage(damage)
	if body != creator:
		queue_free()
