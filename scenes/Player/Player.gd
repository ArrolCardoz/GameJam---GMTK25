extends CharacterBody2D
class_name Player

@export var MOVE_SPEED:float=250
@onready var pickup_action: PickupAction = $PickupAction

const RAYCASE_LENGTH:float=50

var _pickups_in_range:Array[Pickup]

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("select") and _pickups_in_range.size()>0:

		var pickup:Pickup=_pickups_in_range[0]
		print("I got a : ",pickup.item.name)

		pickup.die()





func _physics_process(_delta: float) -> void:
	var moveVec:Vector2=process_input()
	pickup_action.set_new_dir(moveVec)
	velocity=moveVec*MOVE_SPEED
	move_and_slide()

func process_input()->Vector2:
	var move:Vector2
	move.x=Input.get_axis("left","right")
	move.y=Input.get_axis("up","down")
	return move.normalized()


func on_item_picked_up(pickup:Pickup)->void:
	_pickups_in_range.append(pickup)

func on_item_out_of_range(pickup:Pickup)->void:
	_pickups_in_range.erase(pickup)
