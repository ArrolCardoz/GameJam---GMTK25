extends ItemHolder
class_name wheatBag

@onready var sound: AudioStreamPlayer2D = $sound
const DOUGH = preload("res://resources/Items/dough.tres")
const STATION_NAME:String="trashCan"

func _ready() -> void:
	super()
	_isFull=true

func getItem()->Item:
	sound.play()
	return DOUGH

func remove_item()->void:
	pass

func place_item(item)->void:
	pass
