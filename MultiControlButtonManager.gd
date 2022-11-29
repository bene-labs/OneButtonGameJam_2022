extends Node2D
var MultiControllButton = preload("res://MultiControlButton.gd")

export var selected_button_index = 0
var is_button_held = false
var child_count = 0

func _ready():
	child_count = get_child_count()
	if child_count == 0:
		print("No Buttons!")
		queue_free()
	while !(get_child(selected_button_index) is MultiControllButton):
		selected_button_index += 1
		if selected_button_index >= child_count:
			print("No Buttons!")
			queue_free()
			return
	get_child(selected_button_index).select()
	
func on_tap():
	get_child(selected_button_index).deselect()
	selected_button_index += 1
	if selected_button_index >= child_count:
		selected_button_index = 0
	while !(get_child(selected_button_index) is MultiControllButton):
		selected_button_index += 1
		if selected_button_index >= child_count:
			selected_button_index = 0
	get_child(selected_button_index).select()
	
func _process(delta):
	if Input.is_action_just_pressed("universal_action"):
		$TapTimer.start($TapTimer.wait_time)
	elif Input.is_action_just_released("universal_action"):
		is_button_held = false
		get_child(selected_button_index).set_time_passed_with_button_helt(0.0)
	elif is_button_held and Input.is_action_pressed("universal_action"):
		get_child(selected_button_index).set_time_passed_with_button_helt(\
		get_child(selected_button_index).time_passed_with_button_helt + delta)
		

func _on_TapTimer_timeout():
	if Input.is_action_pressed("universal_action"):
		is_button_held = true
	else:
		on_tap()
