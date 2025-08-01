extends ItemHolder
class_name Oven

const STATION_NAME:String="Oven"
func useStation()->void:
	SignalHub.emit_open_station(station,_item)
