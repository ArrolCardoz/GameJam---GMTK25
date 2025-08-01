extends CharacterBody2D
class_name Player

@export var MOVE_SPEED:float=250
@onready var pickup_action: PickupAction = $PickupAction
@onready var debug_label: Label = $DebugLabel

const INVENTORY_SIZE:int=5
const GROUP_NAME: String = "Player"

var _inventory:Inventory=Inventory.new(INVENTORY_SIZE)
var _pickups_in_range:Array[Pickup]
var _stations_in_range:Array[ItemHolder]
var _can_input:bool=true
var _highlightItem:int=0

func _enter_tree() -> void:
	SignalHub.item_dropped.connect(update_hud)
	SignalHub.current_highlight_item.connect(current_highlight_item)
	add_to_group(GROUP_NAME)


func _unhandled_input(event: InputEvent) -> void:
	if _can_input:
		if Input.is_action_just_pressed("pick"):
			#pick item
			if _inventory.isNotFull() and _pickups_in_range.size()>0:
				pickUpItem()
			#pick item from station
			elif _inventory.isNotFull() and _stations_in_range.size()>0:
				pickItemInStation()


		elif Input.is_action_just_pressed("drop"):
			#place item on station
			if !_inventory.isEmpty() and _stations_in_range.size()>0:
				if !_stations_in_range[0]._isFull:
					placeItemInStation()
				else:
					swapItemInStation()


		elif Input.is_action_just_pressed("use"):
			if _stations_in_range.size()>0:
				if _stations_in_range[0].has_method("useStation"):
					_stations_in_range[0].useStation()


func _physics_process(_delta: float) -> void:
	if _can_input:
		update_debug_label()
		var moveVec:Vector2=process_input()
		pickup_action.set_new_dir(moveVec)
		velocity=moveVec*MOVE_SPEED
		move_and_slide()

func process_input()->Vector2:
	var move:Vector2
	move.x=Input.get_axis("left","right")
	move.y=Input.get_axis("up","down")
	return move.normalized()

func update_debug_label()->void:
	var s:String=""
	debug_label.text = "Pickups: %d, Stations: %d" % [_pickups_in_range.size(), _stations_in_range.size()]

func pickUpItem()->void:
	var pickup:Pickup=_pickups_in_range[0]
	SignalHub.emit_get_highlight_item(_inventory)
	_inventory.add_item(pickup.getItem(),_highlightItem)
	SignalHub.emit_updateHUD(_inventory)
	pickup.die()

func placeItemInStation()->void:
	SignalHub.emit_drop_item_from_player(_inventory)


func placeItemInStationFromStationDialogue(item:Item)->void:
	_stations_in_range[0].setItem(item)

func pickItemInStation()->void:
	if _stations_in_range[0]._isFull:
		var item:Item=_stations_in_range[0].getItem()
		_stations_in_range[0].remove_item()
		SignalHub.emit_get_highlight_item(_inventory)
		_inventory.add_item(item,_highlightItem)
		SignalHub.emit_updateHUD(_inventory)

func swapItemInStation()->void:
	if _stations_in_range[0]._isFull:
				var item:Item=_stations_in_range[0].getItem()
				_inventory.add_item(item)
				SignalHub.emit_drop_item_from_player(_inventory)

func update_hud(item:Item)->void:
	_stations_in_range[0].place_item(item)
	SignalHub.emit_updateHUD(_inventory)

func current_highlight_item(i:int)->void:
	_highlightItem=i



func on_picked_up_in_range(pickup:Pickup)->void:
	_pickups_in_range.append(pickup)

func on_picked_up_out_range(pickup:Pickup)->void:
	_pickups_in_range.erase(pickup)


func on_station_in_range(station:ItemHolder)->void:
	_stations_in_range.append(station)

func on_station_out_of_range(station:ItemHolder)->void:
	_stations_in_range.erase(station)
