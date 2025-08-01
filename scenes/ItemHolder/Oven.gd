extends ItemHolder
class_name Oven
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound

var _cookingItem:Item

const STATION_NAME:String="Oven"
func useStation()->void:
	SignalHub.emit_open_station(station,_item)

func startOven(item:Item)->void:
	_cookingItem=item
	timer.start()

func _on_timer_timeout() -> void:
	sound.play()
	_item=_cookingItem
