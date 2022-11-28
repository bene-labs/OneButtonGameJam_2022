extends KinematicBody2D

enum MovementDirections{
	RIGHT,
	LEFT
}

export (MovementDirections) var move_direction = MovementDirections.RIGHT
export var id = 1 # 1 for player one, two for player 2... etc
export var hookshot_range_multiplier = 3
export var move_speed = 200
export var max_health = 3
export (bool) var bounce_of_obstacles = true
export (bool) var clear_line_on_bounce = false
export (bool) var detach_hookshot_on_bounce = true
export (bool) var use_reflection_angle = false
export var minimum_bounce_angle = -30
export var maximum_bounce_angle = 30
export (Color) var color = Color.red

export var player_textures = []

onready var health = max_health
export var is_invincible = false

onready var reverse_movement = false if move_direction == MovementDirections.RIGHT else true
var swing_start_point = null

var velocity = Vector2.ZERO

var attached_trail = null

var Projectile = preload("res://Projectile.tscn")

func _ready():
	$Sprite.texture = player_textures[id - 1]
	$HealthBar.max_value = max_health
	$HealthBar.value = health
	$Sprite.flip_h = reverse_movement
	$Hookshot/AutoAimer.self_modulate = color
	#collision_layer = 10 + id - 1

func _process(delta):
	if Input.is_action_just_pressed("player%d_action" % id):
		$Hookshot.throw()
	elif Input.is_action_just_released("player%d_action" % id):
		$Hookshot.detach()
		
	# DEBUG
	if Input.is_action_just_pressed("debug_increase_move_speed"):
		move_speed += 1
	if Input.is_action_just_pressed("debug_reduce_move_speed"):
		if move_speed > 0:
			move_speed -= 1

func _physics_process(delta):
	if $Hookshot.connected_obstacle != null:
		$Sprite.rotation = get_angle_to($Hookshot.connected_obstacle.position) + TAU * 0.25
		$Hookshot/Rope.points = [Vector2(0, 0), to_local($Hookshot.connected_obstacle.position)]
		$CollisionShape2D.rotation = $Sprite.rotation
#		global_position =  $Hookshot.rotation_point.get_node("SimulatedPlayerPosition").global_position
		velocity = $Hookshot.rotation_point.get_node("SimulatedPlayerPosition").global_position - global_position
	else:
		velocity = Vector2((-1 if reverse_movement else 1) * move_speed * delta, 0).rotated($Sprite.rotation)
	move_and_collide(velocity)

func set_reverse_movement(new_reverse_movement):
	reverse_movement = new_reverse_movement
	$Sprite.flip_h = reverse_movement
	$Hookshot.rotation_point.set_x_direction(reverse_movement)

func revert_movement():
	reverse_movement = !reverse_movement
	$Sprite.flip_h = reverse_movement
	$Hookshot.rotation_point.set_x_direction(reverse_movement)

func _on_BounceArea_body_entered(body):
	if bounce_of_obstacles and body.has_method("get_bounce_angle"):
		if $Hookshot.connected_obstacle != null:
			$Hookshot.detach()
		if use_reflection_angle:
			var refclection_angle = body.get_reflection_velocity(Vector2(move_speed / 30, 0).rotated($Sprite.rotation))
			$Sprite.look_at(position + refclection_angle)
			position += refclection_angle
		else:
			$Sprite.rotation = body.get_bounce_angle()
			$Sprite.rotation += deg2rad(rand_range(minimum_bounce_angle, maximum_bounce_angle))
			set_reverse_movement(false)
			position += Vector2(move_speed / 30, 0).rotated($Sprite.rotation)
		if clear_line_on_bounce:
			attached_trail.clear_line()

func take_damage(damage = 1):
	if is_invincible or health <= 0:
		return
	is_invincible = true
	health -= damage
	$HealthBar.value = health
	$AnimationPlayer.play("take_damage")
		
func die():
	$AnimationPlayer.play("die")


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"take_damage":
			if health <= 0:
				die()

func hide_indicator():
	$Hookshot/AutoAimer.hide()

func _exit_tree():
	get_tree().root.get_child(0).restart_after_delay()

func assign_trail(trail):
	attached_trail = trail
	attached_trail.set_line_color(color)

func delete_trail():
	attached_trail.queue_free()

# powerup api
func heal(amount = 1):
	health += amount
	$HealthBar.value = health
	if health > max_health:
		health = max_health

func increase_speed(amount):
	move_speed += amount

func increase_hookshot_range(amount):
	$Hookshot.hookshot_range_multiplier += amount

func shoot_projectiles(ammount, speed):
	var angle = 0
	for i in range(ammount):
		angle += 270 / ammount
		var projectile = Projectile.instance()
		projectile.global_position = global_position
		projectile.get_node("Sprite").rotation_degrees = rotation_degrees
		projectile.get_node("Sprite").rotation_degrees = angle
		projectile.move_speed = speed
		projectile.creator = self
		get_tree().root.get_child(0).call_deferred("add_child", projectile)
		
