extends Node

var tables: Array[Table] = []

signal table_freed

func release_table(table: Table) -> void:
	table._is_occupied = false
	table._reserved_by = null
	emit_signal("table_freed")


func register_table(table: Table) -> void:
	tables.append(table)

func get_free_table() -> Table:
	for table in tables:
		if not table._is_occupied:
			table._is_occupied=true
			return table
	return null
