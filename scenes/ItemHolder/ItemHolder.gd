extends Area2D
class_name ItemHolder

@export var station:Station
@export var _maxItems:int=0

@onready var markers: Node = $markers
@onready var stationSprite: Sprite2D = $Sprite2D

var _currentDir:Station.dir=station.dir.down
var _isFull:bool=false
var _item:Item

func _ready() -> void:
	updateStationSprite()

func updateStationSprite()->void:
	stationSprite.texture=station.texture[_currentDir]

func place_item(item)->void:
	if _isFull:return
	_item=item
	for childern in markers.get_children():
		var sprite:Marker2D=childern.get_child(0)
		if sprite.texture==null:continue
		sprite.texture=_item.texture



func _on_area_entered(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_station_in_range(self)


func _on_area_exited(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_station_out_of_range(self)
