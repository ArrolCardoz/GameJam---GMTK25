extends Node

var tables: Array[Table] = []
var customerQueue:Array[BaseNPC]=[]


func register_table(table: Table) -> void:
	tables.append(table)
	table_free(table)

func request_table(npc: BaseNPC) -> void:
	for table in tables:
		if not table._is_occupied:
			foundTable(npc,table)

			return
	# No free table, add NPC to queue
	customerQueue.append(npc)
	print(customerQueue)

func table_free(table: Table) -> void:
	if customerQueue.size() > 0:
		var next_npc: BaseNPC = customerQueue.pop_front()
		foundTable(next_npc,table)


func foundTable(npc:BaseNPC,table:Table)->void:
	table._is_occupied = true
	table.reserve(npc)
	npc.assign_table(table)

func reset():
	tables.clear()
	customerQueue.clear()
