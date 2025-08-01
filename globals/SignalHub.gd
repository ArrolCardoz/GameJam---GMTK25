extends Node


signal updateHUD(inventory:Inventory)
func emit_updateHUD(inventory:Inventory)->void:
	updateHUD.emit(inventory)

signal updateHUDthoughArray(arr:Array[Item])
func emit_updateHUDthoughArray(arr:Array[Item])->void:
	updateHUDthoughArray.emit(arr)

signal drop_item_from_player(inventory:Inventory)
func emit_drop_item_from_player(inventory:Inventory)->void:
	drop_item_from_player.emit(inventory)

signal item_dropped(item:Item)
func emit_item_dropped(item:Item)->void:
	item_dropped.emit(item)

signal open_station(station:Station,item:Item)
func emit_open_station(station:Station,item:Item)->void:
	open_station.emit(station,item)

signal get_highlight_item(inventory:Inventory)
func emit_get_highlight_item(inventory:Inventory)->void:
	get_highlight_item.emit(inventory)

signal current_highlight_item(i:int)
func emit_current_highlight_item(i:int)->void:
	current_highlight_item.emit(i)
