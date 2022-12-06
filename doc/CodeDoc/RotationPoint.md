<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# RotationPoint

**Extends:** [Node2D](../Node2D)

## Description

## Property Descriptions

### Effects

```gdscript
var Effects
```

Direct Reference to [Anchor Effects](Anchor.gd.md#Effects)

# General Configurations (Configured ingame!)

### rotation\_per\_seconds

```gdscript
export var rotation_per_seconds = 1
```

determines speed (independent of distance)

### is\_rotating

```gdscript
export var is_rotating = false
```

set true to pause rotation

### x\_direction

```gdscript
export var x_direction = 1
```

Clockwise/Counterclockwise = 1/-1

### move\_speed\_multiplier

```gdscript
export var move_speed_multiplier = 1
```

used for fast/slow effect

### outward\_motion

```gdscript
export var outward_motion = 0
```

used for fast/slow effect
used for pull/push effect

# Effect modifiers

### pull\_strength

```gdscript
export var pull_strength = 10
```

How fast the player should move towards the anchor.

### push\_strength

```gdscript
export var push_strength = 10
```

How fast the player should move away from the anchor.

### slow\_multiplier

```gdscript
export var slow_multiplier = 0.75
```

Move speed is multiplied by this while attached to a slowing Anchor.

### fast\_speed\_bonus

```gdscript
export var fast_speed_bonus = 2
```

This is added to your move speed while attached to fast Anchor.

# Internal Usage

### default\_values

```gdscript
var default_values
```

used to restore default

## Method Descriptions

### calc\_and\_set\_rotation\_per\_seconds

```gdscript
func calc_and_set_rotation_per_seconds(speed, radius)
```

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

