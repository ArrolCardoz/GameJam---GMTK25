extends Area2D
class_name Pickup
@export var item:Item



func getItem()->Item:
	return item
func setItem(ITEM:Item)->void:
	item=ITEM


func _ready() -> void:
	var obj=item.scene.instantiate()
	print(obj)
	call_deferred("add_child",obj)


func die()->void:
	monitorable=false
	monitoring=false
	call_deferred("queue_free")


func _on_area_entered(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_item_picked_up(self)


func _on_area_exited(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_item_out_of_range(self)
