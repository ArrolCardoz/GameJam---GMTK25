extends Control
class_name pauseMenu

var _using:bool=false

@onready var pause_menu: pauseMenu = $"."


func _enter_tree() -> void:
	SignalHub.pause_game.connect(pause_game)



func resume_game()->void:
	pause_menu.mouse_filter=Control.MOUSE_FILTER_IGNORE
	hide()
	get_tree().paused = false

func pause_game()->void:
	pause_menu.mouse_filter=Control.MOUSE_FILTER_PASS
	show()
	get_tree().paused=true



func _on_resume_button_down() -> void:
	resume_game()


func _on_restart_button_down() -> void:
	get_tree().reload_current_scene()


func _on_exit_button_down() -> void:
	SignalHub.emit_load_main()
