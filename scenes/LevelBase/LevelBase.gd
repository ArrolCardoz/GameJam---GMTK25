extends Node2D

@export var _currentMenu:Array[Item]
@export var exitMarker:Marker2D


func _ready() -> void:
	GameManager.setExitMarker(exitMarker.global_position)
	populateFoodManager()

func populateFoodManager()->void:
	for i in _currentMenu:
		FoodManager.add_current_menu(i)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("5"):
		SignalHub.emit_start_day(1)
