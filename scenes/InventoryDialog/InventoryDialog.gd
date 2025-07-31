extends Control
class_name InventoryDialog

@onready var h_box_container: HBoxContainer = %HBoxContainer

func _enter_tree() -> void:
	SignalHub.add_item_to_player.connect(update)

func update(inventory:Inventory)->void:
	var items:Array[Item]=inventory.get_items()
	var counter:int=0
	for children in h_box_container.get_children():
		if counter>=items.size():break
		if children.getIsEmpty():
			children.display(items[counter])
			counter+=1
