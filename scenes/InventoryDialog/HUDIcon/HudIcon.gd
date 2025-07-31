extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect
var _is_empty:bool=true

func getIsEmpty()->bool:return _is_empty
func setIsEmpty(value:bool)->void:_is_empty=value



func display(item: Item):
	var instance = item.scene.instantiate()
	if instance is Pizza:
		var state_string = instance.getState()
		var frame_texture = item.icon_frames.get_frame_texture(state_string, 0)
		texture_rect.texture = frame_texture
		_is_empty = false
