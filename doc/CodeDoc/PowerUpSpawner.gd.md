<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# PowerUpSpawner.gd

**Extends:** [Node2D](../Node2D)

## Description

## Enumerations

### RespawnTypes

```gdscript
const RespawnTypes: Dictionary = {"AFTER_COLLECTED":0,"AFTER_ZONE_CREATED":1,"NEVER":2}
```

## Property Descriptions

### PowerUp

```gdscript
export var PowerUp = "[Object:null]"
```

### spawn\_area\_path

```gdscript
export var spawn_area_path = ""
```

### SpawnArea

```gdscript
var SpawnArea
```

### respawn\_type

```gdscript
export var respawn_type = 0
```

export var concurrent_powerups = 1

### spawn\_chance\_AFTER\_ZONE\_CREATED

```gdscript
export var spawn_chance_AFTER_ZONE_CREATED = 25
```

export var concurrent_powerups = 1

### min\_respawn\_delay

```gdscript
export var min_respawn_delay = 5
```

### max\_respawn\_delay

```gdscript
export var max_respawn_delay = 25
```

### spawns\_queued

```gdscript
var spawns_queued
```

## Method Descriptions

### get\_spawn\_position

```gdscript
func get_spawn_position()
```

### spawn\_on\_zoned

```gdscript
func spawn_on_zoned()
```

	for i in range(concurrent_powerups):
		spawn_powerup()

### spawn\_powerup

```gdscript
func spawn_powerup()
```

### queue\_spawn

```gdscript
func queue_spawn()
```

