extends CharacterBody2D

@export var MOVE_SPEED:float=250
@onready var ray_cast: RayCast2D = $RayCast2D

var _previousDir:Vector2=Vector2.RIGHT

const RAYCASE_LENGTH:float=50


func _physics_process(_delta: float) -> void:
	var moveVec:Vector2=process_input()

	if moveVec==Vector2.ZERO:
		ray_cast.target_position=_previousDir*RAYCASE_LENGTH
	else:
		ray_cast.target_position=moveVec*RAYCASE_LENGTH
		_previousDir=moveVec


	velocity=moveVec*MOVE_SPEED
	move_and_slide()

func process_input()->Vector2:
	var move:Vector2
	move.x=Input.get_axis("left","right")
	move.y=Input.get_axis("up","down")
	return move.normalized()
