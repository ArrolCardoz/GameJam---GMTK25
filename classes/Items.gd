extends Resource
class_name Item

@export var name:String
@export var scene:PackedScene
@export var icon_frames:SpriteFrames
@export var state: String = "default"
@export var transitions: Dictionary = {}

func next_state():
	if transitions.has(state):
		state = transitions[state]
