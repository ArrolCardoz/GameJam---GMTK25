extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect
var _is_empty:bool=true

func getIsEmpty()->bool:return _is_empty
func setIsEmpty(value:bool)->void:_is_empty=value



func display(item: Item):
	texture_rect.texture = item.texture
	_is_empty = false
