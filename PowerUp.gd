extends StaticBody2D

enum Types{
	POWERBOOST, # Der Spieler wird schneller
	HARPUNENUPDATE, 
	HEILUNG,
	BOMBE,
}

export var move_speed_upgrade = 50
export var hookshot_length_multipler_upgrade = 1

export (Types) var type = Types.POWERBOOST

func get_name():
	match type:
		Types.POWERBOOST:
			return("Power Boost")
		Types.HARPUNENUPDATE:
			return("Harpunen Update")
		Types.HEILUNG:
			return("Heilung")
		Types.BOMBE:
			return("Bombe")

func _ready():
	$Label.text = get_name()

func use(user):
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
	
