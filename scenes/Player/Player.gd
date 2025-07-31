extends CharacterBody2D
class_name Player

@export var MOVE_SPEED:float=250
@onready var pickup_action: PickupAction = $PickupAction
@onready var debug_label: Label = $DebugLabel

const RAYCASE_LENGTH:float=50

var _inventory:Inventory
var _pickups_in_range:Array[Pickup]
var _count:int=0



func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select") and _pickups_in_range.size()>0:

		var pickup:Pickup=_pickups_in_range[0]
		print("I got a : ",pickup.item.name)
		_count+=1
		print(pickup.item)
		SignalHub.emit_add_item_to_player()
		_inventory.add_item(pickup.item)
		pickup.die()





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
	debug_label.text=s


func on_item_picked_up(pickup:Pickup)->void:
	_pickups_in_range.append(pickup)

func on_item_out_of_range(pickup:Pickup)->void:
	_pickups_in_range.erase(pickup)
