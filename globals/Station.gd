extends Resource
class_name Station
enum dir{left,up,right,down}

@export var texture:Dictionary[dir,Texture2D]
@export var maxItems:int=0

func rotateStation(direction:dir)->int:
	return ((direction+1)%dir.size())
