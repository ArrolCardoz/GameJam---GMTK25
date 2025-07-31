extends Control
class_name InventoryDialog

@onready var h_box_container: HBoxContainer = %HBoxContainer
var counter:int=0
var highlight:int=0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				highlight_slot(0)
			KEY_2:
				highlight_slot(1)
			KEY_3:
				highlight_slot(2)
			KEY_4:
				highlight_slot(3)
			KEY_5:
				highlight_slot(4)


func _enter_tree() -> void:
	SignalHub.add_item_to_player.connect(update)

func update(inventory: Inventory) -> void:
	var items: Array[Item] = inventory.get_items()
	for children in h_box_container.get_children():
		if counter >= items.size(): break
		if children.getIsEmpty():
			children.display(items[counter])
			children.setCountLabel(str(counter + 1))
			counter += 1

func highlight_slot(index: int) -> void:
	var children = h_box_container.get_children()
	for i in children.size():
		var slot = children[i]
		if i == index:
			slot.highlight(true)
		else:
			slot.highlight(false)
