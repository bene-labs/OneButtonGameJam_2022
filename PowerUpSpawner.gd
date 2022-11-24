extends Node2D

export (PackedScene) var PowerUp
#export var concurrent_powerups = 1
export var min_respawn_delay = 5.0
export var max_respawn_delay = 25.0

var spawns_queued = 0

func get_spawn_position():
	var spawn_position = Vector2.ZERO
	spawn_position.x = rand_range($SpawnArea.position.x, $SpawnArea.position.x + $SpawnArea/CollisionShape2D.shape.extents.x)
	spawn_position.y = rand_range($SpawnArea.position.y, $SpawnArea.position.y + $SpawnArea/CollisionShape2D.shape.extents.y)
	return spawn_position

func _ready():
	randomize()
	$PowerUpRespawnDelay.wait_time = rand_range(min_respawn_delay, max_respawn_delay)
	
#	for i in range(concurrent_powerups):
#		spawn_powerup()

func spawn_powerup():
	var new_power_up = PowerUp.instance()
	new_power_up.spawned_by = self
	new_power_up.randomize_type()
	new_power_up.position = get_spawn_position()
	call_deferred("add_child", new_power_up)

func queue_spawn():
	$PowerUpRespawnDelay.start()
	#spawn_powerup()
#	print("Spawn!")
#	spawns_queued += 1
	if $PowerUpRespawnDelay.time_left == $PowerUpRespawnDelay.wait_time:
		$PowerUpRespawnDelay.start()

func _on_PowerUpRespawnDelay_timeout():
	spawn_powerup()
	$PowerUpRespawnDelay.wait_time = rand_range(min_respawn_delay, max_respawn_delay)
#	spawns_queued -= 1
#	if spawns_queued >= 1:
#		$PowerUpRespawnDelay.start()
