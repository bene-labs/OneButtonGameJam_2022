extends StaticBody2D

enum Types{
	POWERBOOST, # Der Spieler wird schneller
	HARPUNENUPDATE, 
	HEILUNG,
	BOMBE
}

export var rarities = {Types.POWERBOOST: 38.0, Types.HARPUNENUPDATE: 35.0, Types.HEILUNG: 2.5, Types.BOMBE:15.5}

export var move_speed_upgrade = 50
export var hookshot_length_multipler_upgrade = 1

export (Types) var type = Types.POWERBOOST # setget set_type

var spawned_by = null
var type_name = "undefined"

#func set_type(value):
#	type = value
#	print("Type set: ", type)
#	match type:
#		Types.POWERBOOST:
#			type_name = "Power Boost"
#		Types.HARPUNENUPDATE:
#			type_name = "Harpunen Update"
#		Types.HEILUNG:
#			type_name = "Heilung"
#		Types.BOMBE:
#			type_name = "Bombe"

			
func get_name():
	print(type)
	match int(type):
		Types.POWERBOOST:
			return "Power Boost"
		Types.HARPUNENUPDATE:
			return "Harpunen Update"
		Types.HEILUNG:
			return "Heilung"
		Types.BOMBE:
			return "Bombe"
		_:
			return "Undefined"

func _ready():
	$Label.text = get_name()

func use(user):
	print(user.name, " used: ", type)
	match type:
		Types.POWERBOOST:
			user.increase_speed(move_speed_upgrade)
		Types.HARPUNENUPDATE:
			user.increase_hookshot_range(hookshot_length_multipler_upgrade)
		Types.HEILUNG:
			user.heal()
		Types.BOMBE:
			user.take_damage()
	queue_free()
	
func _exit_tree():
	if spawned_by != null and spawned_by.has_method("queue_spawn"):
		spawned_by.queue_spawn()
	
func randomize_type():
	type = get_random_type()
	$Label.text = get_name()

func get_random_type():
	var thresholds = []
	var total_chance = 0
	
	for i in range(rarities.values().size()):
		total_chance += rarities.values()[i]
		thresholds.append(total_chance)
	
	var random_number = rand_range(0, total_chance)
	print(random_number)
	print(thresholds)
	print(Types.keys())
	for i in range(thresholds.size() - 1):
		if random_number <= thresholds[i]:
			print("Selected ", i, " == ", Types.keys()[i])
			return Types.keys()[i]
	print("Selected ", Types.keys()[-1])
	return Types.keys()[-1]