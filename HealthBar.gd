class_name HealthBar extends TextureProgress

enum HealthStates {
	FULL,
	MEDIUM,
	LOW,
	VERY_LOW,
}

export var medium_health = 75
export var low_health = 50
export var very_low_health = 20

export var textures = []

func _on_HealthBar_value_changed(value):
	value = value
	
	var percantage = value / max_value * 100
	
	if percantage <= very_low_health:
		texture_progress = textures[-1]
	elif percantage <= low_health:
		texture_progress = textures[-2]
	elif percantage <= medium_health:
		texture_progress = textures[-3]
	else:
		texture_progress = textures[0]
