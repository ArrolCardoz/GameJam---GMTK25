extends Node2D
class_name PickupAction

@onready var area_2d: Area2D = $Area2D


var _current_dir:Vector2=Vector2.RIGHT
var _new_dir:Vector2
var _parent:CharacterBody2D

func _ready() -> void:
	_parent=get_parent()

func get_character()->CharacterBody2D:
	return _parent

func _physics_process(delta: float) -> void:
	if _new_dir != _current_dir and _new_dir != Vector2.ZERO:
		_current_dir=_new_dir
		area_2d.rotation = _current_dir.angle()

func set_new_dir(newDir:Vector2)->void:
	_new_dir=newDir
