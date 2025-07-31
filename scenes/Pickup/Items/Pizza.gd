extends Node2D
class_name Pizza

enum STATES { dough , rolledDough , sausedDough , cheeseDough , pepproniDough , cheesePizza , pepproniPizza ,
 cheesePizzaSliced , pepproniPizzaSliced }



@export var _state:STATES=STATES.dough
@export var transisionState:Dictionary[STATES,STATES]

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	setState(_state)

func setState(state:STATES)->void:
	_state=state
	var enum_string_name: String = STATES.keys()[state]
	animated_sprite_2d.play(enum_string_name)


func getState()->String:
	return STATES.keys()[_state]

func nextState()->void:
	if !transisionState.has(_state): return
	var state=transisionState[_state]

	setState(state)
