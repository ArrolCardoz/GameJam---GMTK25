extends Node2D

const ADD_OBJECT: String = "add_object"



func _enter_tree() -> void:
	print("ObjectMaker entered tree")
	SignalHub.spawn_customer.connect(spawn_customer)
	print("Connected to spawn_customer")


func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos


func spawn_customer(scene:PackedScene,pos:Vector2)->void:
	var customer=scene.instantiate()
	call_deferred(ADD_OBJECT, customer, pos)
