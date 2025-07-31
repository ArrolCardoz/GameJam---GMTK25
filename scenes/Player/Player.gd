extends CharacterBody2D
class_name Player

@export var MOVE_SPEED:float=250
@onready var pickup_action: PickupAction = $PickupAction
@onready var debug_label: Label = $DebugLabel

const INVENTORY_SIZE:int=5

var _inventory:Inventory=Inventory.new(INVENTORY_SIZE)
var _pickups_in_range:Array[Pickup]
var _stations_in_range:Array[ItemHolder]

func _enter_tree() -> void:
	SignalHub.item_dropped.connect(update_hud)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		#pick item
		if _inventory.isNotFull() and _pickups_in_range.size()>0:
			var pickup:Pickup=_pickups_in_range[0]
			_inventory.add_item(pickup.getItem())
			SignalHub.emit_add_item_to_player(_inventory)
			pickup.die()
		#place item on station
		elif !_inventory.isEmpty() and _stations_in_range.size()>0:
			if !_stations_in_range[0]._isFull:
				SignalHub.emit_drop_item_from_player(_inventory)
			else:
				var item:Item=_stations_in_range[0].getItem()
				_inventory.add_item(item)
				SignalHub.emit_drop_item_from_player(_inventory)

		#pick item from station
		elif _inventory.isNotFull() and _stations_in_range.size()>0:
			pass





func _physics_process(_delta: float) -> void:
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
	s+=str(_pickups_in_range.size())
	s+=str(_stations_in_range.size())
	debug_label.text=s

func update_hud(item:Item)->void:
	_stations_in_range[0].place_item(item)
	SignalHub.emit_add_item_to_player(_inventory)



func on_picked_up_in_range(pickup:Pickup)->void:
	_pickups_in_range.append(pickup)

func on_picked_up_out_range(pickup:Pickup)->void:
	_pickups_in_range.erase(pickup)


func on_station_in_range(station:ItemHolder)->void:
	_stations_in_range.append(station)

func on_station_out_of_range(station:ItemHolder)->void:
	_stations_in_range.erase(station)
