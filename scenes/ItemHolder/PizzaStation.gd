extends ItemHolder
class_name PizzaStation
@onready var sound: AudioStreamPlayer2D = $Sound

const STATION_NAME:String="PizzaStation"
func useStation()->void:
	sound.play()
	SignalHub.emit_open_station(station,_item)
