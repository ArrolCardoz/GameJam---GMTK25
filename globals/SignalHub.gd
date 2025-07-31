extends Node


signal add_item_to_player()
func emit_add_item_to_player()->void:
	add_item_to_player.emit()
