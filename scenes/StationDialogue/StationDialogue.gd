extends PanelContainer
class_name StationDialogue

@onready var pizza_station: TextureRect = $PizzaStation
@onready var item_texture: TextureRect = $itemTexture

var _usingStation:bool=false
var _currentStation:TextureRect
var _currentItem:Item
var _player_ref:Player
var _player_inventory:Array[Item]

func setCurrentItem(i:Item)->void:
	_currentItem=i
	if i==null:item_texture.texture=null
	else:
		item_texture.texture=_currentItem.texture

func _unhandled_input(event: InputEvent) -> void:
	if _usingStation:
		if Input.is_action_just_pressed("ese"):
			hide()
			_usingStation=false
			_currentStation.hide()
			_player_ref.placeItemInStationFromStationDialogue(_currentItem)
			_player_ref._inventory.replace_inventory(_player_inventory)
			_player_ref._can_input=true
			SignalHub.emit_updateHUD(_player_ref._inventory)
			mouse_filter=Control.MOUSE_FILTER_IGNORE

		elif Input.is_action_just_pressed("1"):
			swap_array_and_var(_player_inventory, 0)
		elif Input.is_action_just_pressed("2"):
			swap_array_and_var(_player_inventory, 1)
		elif Input.is_action_just_pressed("3"):
			swap_array_and_var(_player_inventory, 2)
		elif Input.is_action_just_pressed("4"):
			swap_array_and_var(_player_inventory, 3)
		elif Input.is_action_just_pressed("5"):
			swap_array_and_var(_player_inventory, 4)



func _enter_tree() -> void:
	SignalHub.open_station.connect(openStation)

func _ready() -> void:
	_player_ref=get_tree().get_first_node_in_group(Player.GROUP_NAME)

func openStation(station:Station,item:Item)->void:
	_player_ref._can_input=false
	show()
	mouse_filter=Control.MOUSE_FILTER_STOP
	_player_inventory=_player_ref._inventory.get_items()

	setCurrentItem(item)
	_usingStation=true
	match station.name:
		Oven.STATION_NAME:
			_currentStation=pizza_station
			pizza_station.show()
			SignalHub.emit_get_highlight_item(_player_ref._inventory)

func swap_array_and_var(arr: Array, index: int) -> void:
	if index >= arr.size():
		return

	# Exact swap, keeping item positions intact
	var temp = arr[index]
	arr[index] = _currentItem
	setCurrentItem(temp)

	SignalHub.emit_updateHUDthoughArray(arr)
