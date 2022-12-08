<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Trail.gd

**Extends:** [Node2D](../Node2D)

## Description

## Property Descriptions

### to\_follow

```gdscript
export var to_follow = ""
```

### create\_shapes

```gdscript
export var create_shapes = true
```

export (float) var minmum_point_distance = 1.0

### fade\_time

```gdscript
export var fade_time = -1
```

export (float) var minmum_point_distance = 1.0
time in seconds afer a point of the line is removed (set negative for a permanent line)

### debug

```gdscript
export var debug: bool = false
```

### intersection\_blacklist

```gdscript
var intersection_blacklist
```

### CapturedArea

```gdscript
var CapturedArea
```

## Method Descriptions

### set\_color

```gdscript
func set_color(color)
```

### clear\_line

```gdscript
func clear_line()
```

### create\_captured\_area\_from\_intersection

```gdscript
func create_captured_area_from_intersection(intersection, points)
```

### find\_intersection

```gdscript
func find_intersection(points)
```

### set\_line\_color

```gdscript
func set_line_color(color)
```

### is\_polygon\_valid

```gdscript
func is_polygon_valid(polygon) -> bool
```

returns false if the area has a height or width of 0

### get\_segment\_intersection <small>(static)</small>

```gdscript
func get_segment_intersection(a, b, c, d)
```

