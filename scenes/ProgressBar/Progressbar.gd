extends TextureProgressBar
class_name Progress

signal died

const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

@export var level_low: int = 25
@export var level_med: int = 50
@export var start_health: int = 100
@export var max_health: int = 100

var _tween: Tween

func _ready() -> void:
	max_value = max_health
	value = start_health



func _process(delta: float)-> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = lerp(COLOR_MIDDLE, COLOR_DANGER,(level_low / value))
	else:
		tint_progress = lerp(COLOR_GOOD, COLOR_MIDDLE,(level_med / value))


func incr_value(v: int) -> void:
	value += v
	if value <= 0:
		died.emit()



func take_damage(v: int) -> void:
	incr_value(-v)


func start_progress(duration: float) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	value = max_value
	_tween.tween_property(self, "value", 0, duration)

func stop_progress() -> void:
	if _tween:
		_tween.kill()
		_tween = null
