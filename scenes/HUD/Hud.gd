extends Control

@onready var cash_label: Label = $MarginContainer/Panel/VBoxContainer/CashLabel
@onready var day_label: Label = $MarginContainer2/Panel/Label
@onready var gameOverPannel: MarginContainer = $MarginContainer3
@onready var day_complete_lable: MarginContainer = $dayCompleteLable

var _cash:int=1000
var _day:int=1

func _enter_tree() -> void:
	SignalHub.start_day.connect(start_day)
	SignalHub.update_cash.connect(update_cash)
	SignalHub.end_day.connect(end_day)
	SignalHub.game_over.connect(gameOver)
	SignalHub.day_over.connect(day_over)
	SignalHub.you_win.connect(you_win)



func _ready() -> void:
	cash_label.text="%d"%_cash

func update_cash(i:int)->void:
	_cash+=i
	cash_label.text="%d"%_cash

func start_day(i:int)->void:
	day_label.text="Day:%s"%i

func end_day()->void:
	_day+=1
	day_label.text="Day:%s\n"%_day
	day_label.text="Press enter to start day"%_day



func gameOver() -> void:
	gameOverPannel.show()

func day_over() -> void:
	day_complete_lable.show()
	await get_tree().create_timer(1).timeout
	day_complete_lable.hide()





func _on_button_button_down() -> void:
	SignalHub.emit_load_main()
