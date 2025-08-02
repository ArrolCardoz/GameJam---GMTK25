extends Area2D
class_name ItemHolder

@export var station:Station
@export var _maxItems:int=0

@onready var markers: Node2D = $markers
@onready var stationSprite: Sprite2D = $Sprite2D

var _currentDir:Station.dir=station.dir.down
var _isFull:bool=false
var _item:Item

func getItem()->Item:return _item
func setItem(item:Item)->void:
	_item=item
	place_item(_item)


func _ready() -> void:
	updateStationSprite()

func updateStationSprite()->void:
	stationSprite.texture=station.texture[_currentDir]


func place_item(item)->void:
	_item=item
	for marker in markers.get_children():
		var sprite:Sprite2D = marker.get_node("Sprite2D")
		if sprite==null or _item==null:continue
		sprite.texture = _item.texture
		_isFull=true
		marker.show()

func remove_item()->void:
	for marker in markers.get_children():
		var sprite:Sprite2D = marker.get_node("Sprite2D")
		if sprite==null:return
		_item=null
		_isFull=false
		marker.hide()

func startStation(item:Item)->void:
	#pure virtual function
	pass


func _on_area_entered(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_station_in_range(self)


func _on_area_exited(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_station_out_of_range(self)
