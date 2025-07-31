extends Node


signal add_item_to_player(inventory:Inventory)
func emit_add_item_to_player(inventory:Inventory)->void:
	add_item_to_player.emit(inventory)

signal drop_item_from_player(inventory:Inventory)
func emit_drop_item_from_player(inventory:Inventory)->void:
	drop_item_from_player.emit(inventory)

signal item_dropped(item:Item)
func emit_item_dropped(item:Item)->void:
	item_dropped.emit(item)
