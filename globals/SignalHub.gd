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

signal day_over()
func emit_day_over()->void:
	day_over.emit()

signal spawn_customer(scene:PackedScene,pos:Vector2)
func emit_spawn_customer(scene:PackedScene,pos:Vector2)->void:
	spawn_customer.emit(scene,pos)

signal start_day(i:int)
func emit_start_day(i:int):
	start_day.emit(i)

signal end_day()
func emit_end_day()->void:
	end_day.emit()
signal no_customers(b:bool)
func emit_no_customers(b:bool)->void:
	no_customers.emit(b)

signal update_cash(i:int)
func emit_update_cash(i:int)->void:
	update_cash.emit(i)

signal spawn_oven(pos:Vector2)
func emit_spawn_oven(pos:Vector2)->void:
	spawn_oven.emit(pos)


signal spawn_table(pos:Vector2)
func emit_spawn_table(pos:Vector2)->void:
	spawn_table.emit(pos)

signal level_complete()
func emit_level_complete()->void:
	level_complete.emit()

signal pause_game()
func emit_pause_game()->void:
	pause_game.emit()

signal resume_game()
func emit_resume_game()->void:
	resume_game.emit()

signal load_level()
func emit_load_level()->void:
	load_level.emit()

signal load_main()
func emit_load_main()->void:
	load_main.emit()

signal game_over()
func emit_game_over():
	game_over.emit()

signal you_win()
func emit_you_win():
	you_win.emit()
