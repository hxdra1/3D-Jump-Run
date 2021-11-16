extends MarginContainer

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer3/HBoxContainer/Cursor
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer4/HBoxContainer2/Cursor2

var current_selection = 0

const erstes_level = preload("res://level_1.tscn")

func _ready():
	set_current_selection(0)
	
func _process(delta):
	if Input.is_action_just_pressed("backward") and current_selection < 1:
		current_selection += 1
		set_current_selection(current_selection)
		
	elif Input.is_action_just_pressed("forward") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
		
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)


func handle_selection(current_selection):
	if current_selection == 0:
		get_tree().change_scene("res://level_1.tscn")
		
	if current_selection == 1:
		get_tree().quit()

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	
	if _current_selection == 0:
		selector_one.text = "-->"
	elif _current_selection == 1:
		selector_two.text = "-->"
		
