extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const MAIN_MENU = preload("res://scenes/MainMenu/MainMenu.tscn")


func _enter_tree() -> void:
	SignalHub.load_main.connect(play_load_main)

func _ready() -> void:
	animation_player.play("RESET")
	animation_player.play("load_level")


func play_load_main()->void:
	animation_player.play("load_main")

func load_amin()->void:
	SignalHub.emit_load_main()
