extends Node2D

@export var _currentMenu:Array[Item]

func _ready() -> void:
	populateFoodManager()

func populateFoodManager()->void:
	for i in _currentMenu:
		FoodManager.add_current_menu(i)
