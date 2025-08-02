extends Node

var tables: Array[Table] = []
var customerQueue:Array[BaseNPC]=[]



func register_table(table: Table) -> void:
	tables.append(table)

func request_table(npc: BaseNPC) -> void:
	for table in tables:
		if not table._is_occupied:
			table._is_occupied = true
			table.reserve(npc)
			npc.assign_table(table)
			return
	# No free table, add NPC to queue
	customerQueue.append(npc)
	print(customerQueue)

func table_free(table: Table) -> void:
	if customerQueue.size() > 0:
		var next_npc: BaseNPC = customerQueue.pop_front()
		table._is_occupied = true
		table.reserve(next_npc)
		next_npc.assign_table(table)
	print("TEST")
