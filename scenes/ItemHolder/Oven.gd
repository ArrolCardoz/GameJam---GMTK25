extends ItemHolder
class_name Oven
@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _cookingItem:Item

const STATION_NAME:String="Oven"
func useStation()->void:
	SignalHub.emit_open_station(station,_item)

func remove_item()->void:
	super()
	animated_sprite_2d.play("default")

func place_item(item)->void:
	super(item)
	if _item==null:
		animated_sprite_2d.play("default")
	else:
		animated_sprite_2d.play("loaded_pizza_raw")

func startStation(item:Item)->void:
	_cookingItem=item
	timer.start()

func _on_timer_timeout() -> void:
	sound.play()
	_item=_cookingItem
	animated_sprite_2d.play("loaded_pizza_cooked")
