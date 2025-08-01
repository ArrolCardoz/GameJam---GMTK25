extends ItemHolder
class_name Table

@onready var sitting_marker: Marker2D = $SittingMarker

var _is_occupied: bool = false
var _current_npc: BaseNPC = null

func _ready() -> void:
	super()
	Tablemanager.register_table(self)

func reserve(npc: BaseNPC):
	_is_occupied = true
	_current_npc = npc

func release():
	_is_occupied = false
	_current_npc = null
