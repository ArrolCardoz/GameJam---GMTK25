extends CharacterBody2D

@export var MOVE_SPEED:float=250



func _physics_process(delta: float) -> void:
	var moveVec:Vector2=process_input()
	velocity=moveVec*MOVE_SPEED
	move_and_slide()

func process_input()->Vector2:
	var move:Vector2
	move.x=Input.get_axis("left","right")
	move.y=Input.get_axis("up","down")
	return move.normalized()
