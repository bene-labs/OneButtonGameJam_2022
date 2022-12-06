<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Anchor

**Extends:** [StaticBody2D](../StaticBody2D)

## Description

An Achor that acts as a target object for the player's hookshoot

If the Hookshot Rope of a player is attached to this object,
a rotation point will be created to handle the player Rotation.

## Enumerations

### Effects

```gdscript
const Effects: Dictionary = {"FAST":3,"NOTHING":0,"PULL":1,"PUSH":2,"SLOW":4}
```

Effects only affect the player while he is attached to and rotating around the Anchor.

Effects are as follows:

|Name   |Description                                            |Color           |Related Variable (provides 'x' value)                        |
|-------|-------------------------------------------------------|----------------|-------------------------------------------------------------|
|Nothing|No Effect                                              |Yellow (default)|None                                                         |
|Push   |Player will move x units towards the anchor each frame.|Purple          |[pull_strength](RotationPoint.md#pull/_strength)       |
|Push   |Player will move x away from the anchor each frame.    |Blue            |[push_strength](RotationPoint.md#push/_strength)       |
|Fast   |Player will move x additional units each frame.        |Green           |[fast_speed_bonus](RotationPoint.md#fast/_speed/_bonus)|
|Slow   |Player will only move at x times the usual speed.      |Red             |[slow_multiplier](RotationPoint.md#slow/_multiplier)   |

## Property Descriptions

### def\_layer

```gdscript
var def_layer
```

Used for Hookshoot collision check.
Players need to mask this layer so they can connect to this anchor.

### connected\_player

```gdscript
var connected_player
```

Used for Hookshoot collision check.
Players need to mask this layer so they can connect to this anchor.

### effect\_colors

```gdscript
export var effect_colors = {"0":"1,1,0,1","1":"0.627451,0.12549,0.941176,1","2":"0,0,1,1","3":"0,1,0,1","4":"1,0,0,1"}
```

### effect

```gdscript
export var effect = 0
```

### randomize\_effect

```gdscript
export var randomize_effect = true
```

## Method Descriptions

### set\_effect

```gdscript
func set_effect(value)
```

### get\_random\_effect

```gdscript
func get_random_effect()
```

### connect\_player

```gdscript
func connect_player(player)
```

### disconnect\_player

```gdscript
func disconnect_player()
```

### deactivate

```gdscript
func deactivate()
```

## Signals

- signal wasHitLoadTutorialScene2(): 
