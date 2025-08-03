extends Node

const LEVEL_BASE = preload("res://scenes/LevelBase/LevelBase.tscn")
const MAIN_MENU = preload("res://scenes/MainMenu/MainMenu.tscn")

var exitMarker:Vector2=Vector2.ZERO
var _cash:int =1000
var _no_customers:bool=false
var _day_over:bool=false

func _enter_tree() -> void:
	SignalHub.update_cash.connect(update_cash)
	SignalHub.no_customers.connect(updateNoCustomer)
	SignalHub.start_day.connect(start_day)
	SignalHub.day_over.connect(update_day_over)
	SignalHub.load_level.connect(load_level)
	SignalHub.load_main.connect(load_main)



func gameOver()->void:
	pass

func start_day(day:int)->void:
	_no_customers=false
	_day_over=false
	if day==1:
		_cash=0
		SignalHub.emit_update_cash(0)

func endDay()->void:
	if (_no_customers and _day_over):
		SignalHub.emit_level_complete()

func setExitMarker(marker:Vector2):exitMarker=marker

func getExitMarker()->Vector2:
	return exitMarker

func update_cash(i:int)->void:
	_cash+=i

func update_day_over()->void:
	_day_over=true

func load_level()->void:
	_day_over=true

func load_main()->void:
	_day_over=true

func updateNoCustomer(b:bool)->void:
	_no_customers=b
	if !b:endDay()
