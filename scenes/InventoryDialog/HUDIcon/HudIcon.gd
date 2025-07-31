extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect
var _is_empty:bool=false

func getIsEmpty()->bool:return _is_empty
func setIsEmpty(value:bool)->void:_is_empty=value



func display(item:Item):
	item.icon_frames.get_frame_texture(item.scene.getState(),0)
