extends ItemHolder
class_name trashCan

@onready var sound: AudioStreamPlayer2D = $sound

const STATION_NAME:String="trashCan"


func remove_item()->void:
	pass

func place_item(item)->void:
	sound.play()
	for marker in markers.get_children():
		if _item==null:continue
