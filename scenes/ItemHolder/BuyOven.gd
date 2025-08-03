extends ItemHolder
class_name buyOven
@onready var sound: AudioStreamPlayer2D = $sound
@onready var cost_label: Label = $costLabel
@export var cost:int=20

const STATION_NAME:String="buyOven"

func _ready() -> void:
	super()
	cost_label.text="Buy Oven for %d"%cost

func useStation()->void:
	if GameManager._cash>cost:
		SignalHub.emit_spawn_oven(global_position)
		SignalHub.emit_update_cash(-cost)
		call_deferred("queue_free")

func _on_area_entered(area: Area2D) -> void:
	super(area)
	cost_label.show()

func _on_area_exited(area: Area2D) -> void:
	super(area)
	cost_label.hide()
