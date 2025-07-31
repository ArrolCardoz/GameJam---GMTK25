extends Node


signal add_item_to_player(inventory:Inventory)
func emit_add_item_to_player(inventory:Inventory)->void:
	add_item_to_player.emit(inventory)
