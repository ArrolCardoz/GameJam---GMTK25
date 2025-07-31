extends PanelContainer

@onready var countLabel: Label = $TextureRect/Count
@onready var texture_rect: TextureRect = %TextureRect
const HIGHLIGHT = preload("res://scenes/InventoryDialog/HUDIcon/Highlight.tres")
const HUD_BG = preload("res://scenes/InventoryDialog/HUDIcon/HUD_BG.tres")

var _is_empty:bool=true

func getIsEmpty()->bool:return _is_empty
func setIsEmpty(value:bool)->void:_is_empty=value

func highlight(state:bool)->void:
	if state:add_theme_stylebox_override("panel",HIGHLIGHT)
	else: add_theme_stylebox_override("panel",HUD_BG)

func display(item: Item):
	texture_rect.texture = item.texture
	_is_empty = false

func setCountLabel(s:String)->void:
	countLabel.show()
	countLabel.text=s
