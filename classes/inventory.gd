class_name Inventory

@export var _content:Array[Item]
var _invSize=0

func _init(size:int) -> void:
	_invSize=size
	_content.resize(_invSize)



func replace_inventory(arr:Array[Item])->void:
	_content = arr.duplicate(true)


func add_item(item:Item,highlight:int)->void:
	if _content[highlight]==null:
		_content[highlight] = item
		return
	for i in range(_content.size()):
		if _content[i] == null:
			_content[i] = item
			break



func remove_item(idx:int)->void:
	_content[idx]=null

func get_items()->Array[Item]:
	return _content

func isNotFull()->bool:
	for i in _content:
		if i==null:return true
	return false

func isEmpty()->bool:
	for i in _content:
		if i!=null:return false
	return true
