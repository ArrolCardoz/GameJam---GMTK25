extends Node2D

@export var _currentMenu:Array[Item]
@export var exitMarker:Marker2D
@onready var recipie_book: Control = $CanvasLayer/RecipieBook

var _dayNum:int=1
var _lastLevel:int=5
var _canStartDay:bool=true

func _enter_tree() -> void:
	SignalHub.level_complete.connect(update_canStartDay)

func _ready() -> void:
	GameManager.setExitMarker(exitMarker.global_position)
	populateFoodManager()

func populateFoodManager()->void:
	for i in _currentMenu:
		FoodManager.add_current_menu(i)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("startDay"):
		if _dayNum<_lastLevel:
			_canStartDay=false
			SignalHub.emit_start_day(_dayNum)
		else: SignalHub.emit_you_win()
	elif Input.is_action_just_pressed("ese"):
		SignalHub.emit_pause_game()
	elif Input.is_action_just_pressed("RecipieBook"):
		recipie_book.show()
	elif !Input.is_action_pressed("RecipieBook"):
		recipie_book.hide()

func update_canStartDay()->void:
	_canStartDay=true
