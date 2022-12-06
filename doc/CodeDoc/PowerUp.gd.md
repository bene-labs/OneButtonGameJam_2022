<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# PowerUp.gd

**Extends:** [StaticBody2D](../StaticBody2D)

## Description

## Enumerations

### Types

```gdscript
const Types: Dictionary = {"BOMBE":3,"HARPUNENUPDATE":1,"HEILUNG":2,"KABOOM":4,"POWERBOOST":0}
```

## Property Descriptions

### textures

```gdscript
export var textures = []
```

### rarities

```gdscript
export var rarities = {"BOMBE":10,"HARPUNENUPDATE":30,"HEILUNG":5,"Kaboom!":15,"POWERBOOST":40}
```

### move\_speed\_upgrade

```gdscript
export var move_speed_upgrade = 50
```

### hookshot\_length\_multipler\_upgrade

```gdscript
export var hookshot_length_multipler_upgrade = 1
```

### projectile\_speed

```gdscript
export var projectile_speed = 300
```

### type

```gdscript
export var type = 0
```

setget set_type

### spawned\_by

```gdscript
var spawned_by
```

### type\_name

```gdscript
var type_name
```

## Method Descriptions

### get\_name

```gdscript
func get_name()
```

### use

```gdscript
func use(user)
```

### randomize\_type

```gdscript
func randomize_type()
```

### get\_random\_type

```gdscript
func get_random_type()
```

## Signals

- signal wasHitLoadTutorialScene3(): 
