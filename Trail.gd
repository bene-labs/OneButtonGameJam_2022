extends Node2D

export (NodePath) var to_follow
export var fade_time = 5.0 # time in seconds afer a point of the line is removed (set negative for a permanent line)

func _on_Trail_Timer_timeout():
	var points_copy = $Line.points
	points_copy.append(get_node(to_follow).global_position)
	if fade_time > 0 and $Line.points.size() > fade_time / $Timer.wait_time:
		points_copy.remove(0)
	$Line.points = points_copy
