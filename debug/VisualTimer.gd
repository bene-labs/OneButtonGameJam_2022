class_name VisualTimer extends Label

var time_passed = 0.0

func _process(delta):
	time_passed += delta
	text = "%.3f sec" % time_passed
