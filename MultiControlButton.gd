extends Button

export var label_text = "Button"

export (NodePath) var on_clicked_function_location = "."
export var on_clicked_function_name = "on_clicked_default"
export var on_clicked_function_params = []

export (NodePath) var on_selected_function_location = "."
export var on_selected_function_name = "on_selected_default"
export var on_selected_function_params = []
export var button_activation_time = 3.0
var time_passed_with_button_helt = 0.0 setget set_time_passed_with_button_helt

var _on_clicked = FuncRef.new()
var _on_selected = FuncRef.new()

signal selected
signal deselected
signal activated

var button_selected = false

func set_time_passed_with_button_helt(value):
	time_passed_with_button_helt = value
	$Fill.value = time_passed_with_button_helt / button_activation_time * 100
	if time_passed_with_button_helt >= button_activation_time:
		$Fill.value = 0
		time_passed_with_button_helt = 0
		emit_signal("activated")

func _ready():
	$Label.text = label_text
	$Border.hide()
	_on_clicked.set_instance(get_node(on_clicked_function_location))
	_on_clicked.function = on_clicked_function_name
	_on_selected.set_instance(get_node(on_selected_function_location))
	_on_selected.function = on_selected_function_name

func on_clicked_default():
	print("Button '", name, "': Click was triggered, but no function is assigned!")

func on_selected_default():
	print("Button '", name, "': Selection was triggered, but no function is assigned!")

func _on_MultiControlButton_pressed():
	emit_signal("activated")

func select():
	$Border.show()
	emit_signal("selected")

func deselect():
	$Border.hide()

func _on_MultiControlButton_mouse_entered():
	emit_signal("selected")

func _on_MultiControlButton_selected():
	_on_selected.call_funcv(on_selected_function_params)

func activate():
	$AnimationPlayer.play("Click")

func _on_MultiControlButton_activated():
	_on_clicked.call_funcv(on_clicked_function_params)


func _on_MultiControlButton_mouse_exited():
	pass # Replace with function body.
