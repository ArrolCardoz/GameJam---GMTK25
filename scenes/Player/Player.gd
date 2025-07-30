extends CharacterBody2D

@export var MOVE_SPEED:float=250



func _physics_process(delta: float) -> void:
	process_input()
