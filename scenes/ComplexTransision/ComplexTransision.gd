extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer
const LEVEL_BASE = preload("res://scenes/LevelBase/LevelBase.tscn")
func _enter_tree() -> void:
	SignalHub.load_level.connect(play_load_level)

func _ready() -> void:
	animation_player.play("load_main")


func play_load_level()->void:
	animation_player.play("load_level")

func load_level()->void:
	get_tree().change_scene_to_packed(LEVEL_BASE)
