extends PanelContainer
class_name StationDialogue

@onready var oven: TextureRect = $Oven
@onready var item_texture: TextureRect = $itemTexture
@onready var recipie_manager: Node = $RecipieManager
@onready var pizza_timer: Timer = $Oven/OvenTimer
@onready var pizza_station: TextureRect = $PizzaStation


var _usingStation:bool=false
var _currentDiaogue:TextureRect
var _currentItem:Item
var _player_ref:Player
var _player_inventory:Array[Item]
var _currentStation:Station
var _just_opened :bool= false
var _cookingItem:Item

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
			_currentDiaogue.hide()
			_player_ref.placeItemInStationFromStationDialogue(_currentItem)
			_player_ref._inventory.replace_inventory(_player_inventory)
			_player_ref._can_input=true
			SignalHub.emit_updateHUD(_player_ref._inventory)

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
		elif Input.is_action_just_pressed("use") and not _just_opened:
			useStation()



func _enter_tree() -> void:
	SignalHub.open_station.connect(openStation)

func _ready() -> void:
	_player_ref=get_tree().get_first_node_in_group(Player.GROUP_NAME)

func openStation(station:Station,item:Item)->void:
	_player_ref._can_input=false
	show()
	_player_inventory=_player_ref._inventory.get_items()
	_currentStation=station
	_just_opened = true # prevent immediate input
	setCurrentItem(item)
	_usingStation=true
	match station.name:
		Oven.STATION_NAME:
			_currentDiaogue=oven
			oven.show()
			SignalHub.emit_get_highlight_item(_player_ref._inventory)
			await get_tree().create_timer(0.1).timeout
			_just_opened = false
		PizzaStation.STATION_NAME:
			_currentDiaogue=pizza_station


func swap_array_and_var(arr: Array, index: int) -> void:
	if index >= arr.size():
		return

	# Exact swap, keeping item positions intact
	var temp = arr[index]
	arr[index] = _currentItem
	setCurrentItem(temp)

	SignalHub.emit_updateHUDthoughArray(arr)

func useStation()->void:
	var item:Item=recipie_manager.get_result_for(_currentItem,_currentStation)
	_cookingItem=item
	if _cookingItem==null:
		return
	match _currentStation.name:
		Oven.STATION_NAME:
			_player_ref._stations_in_range[0].startStation(_cookingItem)
			setCurrentItem(null)
			pizza_timer.start()


func _on_pizza_timer_timeout() -> void:
	setCurrentItem(_cookingItem)
