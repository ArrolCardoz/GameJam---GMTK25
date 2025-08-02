extends Resource
class_name Waves


@export var wave: Array[Wave]

func get_wave_for_wave_count(wc: int) -> Wave:
	return wave[wc % wave.size()]


func wave_is_start(wc: int) -> bool:
	return wc % wave.size() == 0
