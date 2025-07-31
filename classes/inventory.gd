class_name Inventory

@export var _content:Array[Item]=[]

func add_item(item:Item)->void:
	_content.append(item)

func remove_item(item:Item)->void:
	_content.erase(item)

func get_items()->Array[Item]:
	return _content
