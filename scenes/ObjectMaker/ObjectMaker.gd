extends Node2D



const ADD_OBJECT: String = "add_object"

const TABLE = preload("res://scenes/ItemHolder/Table.tscn")
const OVEN = preload("res://scenes/ItemHolder/Oven.tscn")
const OVEN_RESOURCE = preload("res://resources/Stations/oven.tres")
const TABLE_RESOURCE = preload("res://resources/Stations/Table.tres")

func _enter_tree() -> void:
	SignalHub.spawn_customer.connect(spawn_customer)
	SignalHub.spawn_oven.connect(spawn_oven)
	SignalHub.spawn_table.connect(spawn_table)



func add_object(obj: Node, pos: Vector2) -> void:
	obj.global_position = pos
	add_child(obj)


func spawn_customer(scene:PackedScene,pos:Vector2)->void:
	var customer=scene.instantiate()
	call_deferred(ADD_OBJECT, customer, pos)

func spawn_oven(pos:Vector2)->void:
	var oven:Oven=OVEN.instantiate()
	oven.station=OVEN_RESOURCE
	call_deferred(ADD_OBJECT, oven, pos)


func spawn_table(pos:Vector2)->void:
	var table:Table=TABLE.instantiate()
	table.station=TABLE_RESOURCE
	call_deferred(ADD_OBJECT, table, pos)
