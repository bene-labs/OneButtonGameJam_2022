<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Player.gd

**Extends:** [KinematicBody2D](../KinematicBody2D)

## Description

## Enumerations

### MovementDirections

```gdscript
const MovementDirections: Dictionary = {"LEFT":1,"RIGHT":0}
```

## Property Descriptions

### move\_direction

```gdscript
export var move_direction = 0
```

### id

```gdscript
export var id = 1
```

1 for player one, two for player 2... etc

### hookshot\_range\_multiplier

```gdscript
export var hookshot_range_multiplier = 3
```

### move\_speed

```gdscript
export var move_speed = 200
```

### max\_health

```gdscript
export var max_health = 3
```

### bounce\_of\_obstacles

```gdscript
export var bounce_of_obstacles = true
```

### clear\_line\_on\_bounce

```gdscript
export var clear_line_on_bounce = false
```

### detach\_hookshot\_on\_bounce

```gdscript
export var detach_hookshot_on_bounce = true
```

### use\_reflection\_angle

```gdscript
export var use_reflection_angle = false
```

### minimum\_bounce\_angle

```gdscript
export var minimum_bounce_angle = -30
```

### maximum\_bounce\_angle

```gdscript
export var maximum_bounce_angle = 30
```

### colors

```gdscript
export var colors = ["1,0,0,1","0,0,1,1"]
```

### color

```gdscript
var color
```

### health

```gdscript
var health
```

### is\_invincible

```gdscript
export var is_invincible = false
```

### reverse\_movement

```gdscript
var reverse_movement
```

### swing\_start\_point

```gdscript
var swing_start_point
```

### velocity

```gdscript
var velocity
```

### attached\_trail

```gdscript
var attached_trail
```

### Projectile

```gdscript
var Projectile
```

## Method Descriptions

### set\_reverse\_movement

```gdscript
func set_reverse_movement(new_reverse_movement)
```

### revert\_movement

```gdscript
func revert_movement()
```

### take\_damage

```gdscript
func take_damage(damage = 1)
```

### die

```gdscript
func die()
```

### hide\_indicator

```gdscript
func hide_indicator()
```

### assign\_trail

```gdscript
func assign_trail(trail)
```

### delete\_trail

```gdscript
func delete_trail()
```

### heal

```gdscript
func heal(amount = 1)
```

powerup api

### increase\_speed

```gdscript
func increase_speed(amount)
```

### increase\_hookshot\_range

```gdscript
func increase_hookshot_range(amount)
```

### shoot\_projectiles

```gdscript
func shoot_projectiles(ammount, speed)
```

