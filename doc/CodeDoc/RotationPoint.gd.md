<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# RotationPoint.gd

**Extends:** [Node2D](../Node2D)

## Description

## Property Descriptions

### Effects

```gdscript
var Effects
```

### rotation\_per\_seconds

```gdscript
export var rotation_per_seconds = 1
```

### is\_rotating

```gdscript
export var is_rotating = false
```

### x\_direction

```gdscript
export var x_direction = 1
```

1 or -1

### move\_speed\_multiplier

```gdscript
export var move_speed_multiplier = 1
```

### outward\_motion

```gdscript
export var outward_motion = 0
```

### default\_values

```gdscript
var default_values
```

## Method Descriptions

### calc\_and\_set\_rotation\_per\_seconds

```gdscript
func calc_and_set_rotation_per_seconds(speed, radius)
```

			if $SimulatedPlayerPosition.position.x < 0:
				$SimulatedPlayerPosition.position.x = 0

### start\_rotation

```gdscript
func start_rotation()
```

### stop\_rotation

```gdscript
func stop_rotation()
```

### set\_x\_direction

```gdscript
func set_x_direction(is_right: bool)
```

### set\_simulate\_player\_position

```gdscript
func set_simulate_player_position(position)
```

### reset

```gdscript
func reset()
```

### trigger\_effect

```gdscript
func trigger_effect(effect)
```

