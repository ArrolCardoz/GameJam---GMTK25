extends Area2D
class_name Pickup
@export var item:Item
@onready var sprite_2d: Sprite2D = $Sprite2D



func getItem()->Item:
	return item
func setItem(ITEM:Item)->void:
	item=ITEM


func _ready() -> void:
	sprite_2d.texture=item.texture


func die()->void:
	monitorable=false
	monitoring=false
	call_deferred("queue_free")


func _on_area_entered(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_picked_up_in_range(self)


func _on_area_exited(area: Area2D) -> void:
	var parent:= area.get_parent()
	if parent is PickupAction:
		parent.get_character().on_picked_up_out_range(self)
