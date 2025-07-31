class_name Inventory

@export var _content:Array[Item]
var _invSize=0

func _init(size:int) -> void:
	_invSize=size

func add_item(item:Item)->void:
	_content.append(item)

func remove_item(item:Item)->void:
	_content.erase(item)

func get_items()->Array[Item]:
	return _content

func isNotFull()->bool:
	return _invSize>_content.size()

func isEmpty()->bool:
	return _content.is_empty()
