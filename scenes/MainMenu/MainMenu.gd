extends Control
class_name MainMenu


func _on_play_button_down() -> void:
	SignalHub.emit_load_level()
