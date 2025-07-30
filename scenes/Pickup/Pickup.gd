extends Area2D

@export var item:Item

func _ready() -> void:
	var obj=item.scene.instantiate()
	call_deferred("add_child",obj)




func _on_area_entered(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_item_picked_up(item)


func _on_area_exited(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_item_out_of_range(item)
