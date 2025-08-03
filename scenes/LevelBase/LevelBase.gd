extends Node2D

@export var _currentMenu:Array[Item]
@export var exitMarker:Marker2D
@onready var recipie_book: Control = $CanvasLayer/RecipieBook

var _dayNum:int=1
var _lastLevel:int=5
var _canStartDay:bool=true
var _stationDialogue_ref:StationDialogue

func _enter_tree() -> void:
	Tablemanager.reset()
	SignalHub.level_complete.connect(update_canStartDay)

func _ready() -> void:

	_stationDialogue_ref=get_tree().get_first_node_in_group(StationDialogue.GROUP_NAME)
	GameManager.setExitMarker(exitMarker.global_position)
	populateFoodManager()

func populateFoodManager()->void:
	for i in _currentMenu:
		FoodManager.add_current_menu(i)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("startDay"):
		if _canStartDay:
			_canStartDay=false
			if _dayNum>_lastLevel :
				SignalHub.emit_you_win()
			else:SignalHub.emit_start_day(_dayNum)
	elif !_stationDialogue_ref._usingStation and Input.is_action_just_pressed("ese"):
		await get_tree().create_timer(0.1).timeout
		SignalHub.emit_pause_game()
	elif Input.is_action_just_pressed("RecipieBook"):
		recipie_book.show()
	elif !Input.is_action_pressed("RecipieBook"):
		recipie_book.hide()

func update_canStartDay()->void:
	_canStartDay=true
	_dayNum+=1
