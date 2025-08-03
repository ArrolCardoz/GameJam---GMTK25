extends PanelContainer
class_name StationDialogue

@onready var oven: TextureRect = $Oven
@onready var item_of_oven: TextureRect = $Oven/item_of_oven
@onready var recipie_manager: Node = $RecipieManager
@onready var pizza_timer: Timer = $Oven/OvenTimer
@onready var pizza_station: TextureRect = $PizzaStation
@onready var item_of_pizza_station: TextureRect = $PizzaStation/itemOfPizzaStation
@onready var open_door: TextureRect = $Oven/openDoor
@onready var closed_door: TextureRect = $Oven/closedDoor
@onready var sound: AudioStreamPlayer2D = $Sound



const GROUP_NAME:String="StationDialogue"
var _usingStation:bool=false
var _currentDiaogue:TextureRect
var _currentItem:Item
var _player_ref:Player
var _player_inventory:Array[Item]
var _currentStation:Station
var _just_opened :bool= false
var _cookingItem:Item
var _displayItem:TextureRect

func _enter_tree() -> void:
	SignalHub.open_station.connect(openStation)
	add_to_group(GROUP_NAME)

func setCurrentItem(i:Item)->void:
	_currentItem=i

	if i==null:_displayItem.texture=null
	else:
		_displayItem.texture=_currentItem.texture

func _unhandled_input(event: InputEvent) -> void:
	if _usingStation:
		if Input.is_action_just_released("ese"):
			_usingStation=false
			hide()
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
		if _currentStation.name==Oven.STATION_NAME:
			if Input.is_action_just_pressed("use") and not _just_opened:
				useStation()
		elif _currentStation.name==PizzaStation.STATION_NAME:
			if _currentItem==null:return
			elif Input.is_action_just_pressed("left")and _currentItem.name=="dough":
				useStation()
			elif Input.is_action_just_pressed("drop")and _currentItem.name=="cheeseAndSausedDough":
				useStation()
			elif Input.is_action_just_pressed("up")and _currentItem.name=="sausedDough":
				useStation()
			elif Input.is_action_just_pressed("pick")and _currentItem.name=="rolledDough":
				useStation()
			elif Input.is_action_just_pressed("right")and (_currentItem.name=="pepproniPizza"or\
			_currentItem.name=="cheesePizza") :
				useStation()




func _ready() -> void:
	_player_ref=get_tree().get_first_node_in_group(Player.GROUP_NAME)

func openStation(station:Station,item:Item)->void:
	_player_ref._can_input=false
	show()
	_player_inventory=_player_ref._inventory.get_items()
	_currentItem=item
	_currentStation=station
	_just_opened = true # prevent immediate input
	_usingStation=true
	match station.name:
		Oven.STATION_NAME:
			ovenOpenDoor()
			_currentDiaogue=oven
			_displayItem=item_of_oven
		PizzaStation.STATION_NAME:
			_currentDiaogue=pizza_station
			_displayItem=item_of_pizza_station
	openDialogue()


func openDialogue()->void:
	setCurrentItem(_currentItem)
	_currentDiaogue.show()
	SignalHub.emit_get_highlight_item(_player_ref._inventory)
	await get_tree().create_timer(0.1).timeout
	_just_opened = false

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
			ovenCloseDoor()
		PizzaStation.STATION_NAME:
			setCurrentItem(_cookingItem)
			sound.play()

func ovenOpenDoor()->void:
	open_door.show()
	closed_door.hide()

func ovenCloseDoor()->void:
	open_door.hide()
	closed_door.show()

func _on_pizza_timer_timeout() -> void:
	ovenOpenDoor()
	setCurrentItem(_cookingItem)
