extends Node

var exitMarker:Vector2=Vector2.ZERO


func gameOver()->void:
	pass

func setExitMarker(marker:Vector2):exitMarker=marker

func getExitMarker()->Vector2:
	return exitMarker
