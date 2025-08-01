extends Node
var _currentMenu:Array[Item]

func get_random_food()->Item:
	return _currentMenu.pick_random()

func get_current_menu()->Array[Item]:return _currentMenu
func add_current_menu(item:Item)->void:_currentMenu.append(item)
