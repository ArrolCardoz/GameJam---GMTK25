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
	print( !_inventory.isEmpty() and _stations_in_range.size()>0)
	if Input.is_action_just_pressed("select"):
		if _inventory.isFull() and _pickups_in_range.size()>0:
			var pickup:Pickup=_pickups_in_range[0]
			_inventory.add_item(pickup.getItem())
			SignalHub.emit_add_item_to_player(_inventory)
			pickup.die()
		elif !_inventory.isEmpty() and _stations_in_range.size()>0:
			print("TEST")
			SignalHub.emit_drop_item_from_player(_inventory)




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
	_inventory.remove_item(item)
	SignalHub.emit_add_item_to_player(_inventory)




func on_picked_up_in_range(pickup:Pickup)->void:
	_pickups_in_range.append(pickup)

func on_picked_up_out_range(pickup:Pickup)->void:
	_pickups_in_range.erase(pickup)


func on_station_in_range(station:ItemHolder)->void:
	_stations_in_range.append(station)

func on_station_out_of_range(station:ItemHolder)->void:
	_stations_in_range.erase(station)
