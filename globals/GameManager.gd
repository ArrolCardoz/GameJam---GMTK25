extends Node

var exitMarker:Vector2=Vector2.ZERO
var _cash:int =1000

func _enter_tree() -> void:
	SignalHub.update_cash.connect(update_cash)

func gameOver()->void:
	pass

func setExitMarker(marker:Vector2):exitMarker=marker

func getExitMarker()->Vector2:
	return exitMarker

func update_cash(i:int)->void:
	_cash+=i
