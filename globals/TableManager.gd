extends Node

var tables: Array[Table] = []

func register_table(table: Table) -> void:
	tables.append(table)

func get_free_table() -> Table:
	for table in tables:
		if not table._is_occupied:
			return table
	return null
