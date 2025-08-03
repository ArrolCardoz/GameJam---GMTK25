extends Control

@onready var cash_label: Label = $MarginContainer/Panel/VBoxContainer/CashLabel
@onready var day_label: Label = $MarginContainer2/Panel/Label
@onready var gameOverPannel: MarginContainer = $MarginContainer3
@onready var day_complete_lable: MarginContainer = $dayCompleteLable
@onready var game_over_lable: Label = $MarginContainer3/VBoxContainer/Panel/GameOverLAble

var _cash:int=0
var _day:int=1
var _time:float
var _level_started:bool=false

func _enter_tree() -> void:
	SignalHub.start_day.connect(start_day)
	SignalHub.update_cash.connect(update_cash)
	SignalHub.end_day.connect(end_day)
	SignalHub.game_over.connect(gameOver)
	SignalHub.level_complete.connect(day_over)
	SignalHub.you_win.connect(you_win)



func _ready() -> void:
	cash_label.text="%d"%_cash

func _process(delta: float) -> void:
	if _level_started:
		_time+=delta
		var s:String=""
		s+="Day:%s\n"%_day
		var progress:float=_time*100/180
		s+="Progress:%d%%"%progress
		day_label.text=s


func update_cash(i:int)->void:
	_cash+=i
	cash_label.text="%d"%_cash

func start_day(i:int)->void:
	_level_started=true
	day_label.text="Day:%d"%i
	_time=0

func end_day()->void:
	_level_started=false
	_time=0
	_day+=1
	var s:String=""
	s+="Day:%s\n"%_day
	s+="Press enter to start day"%_day
	day_label.text=s



func gameOver() -> void:
	gameOverPannel.show()

func you_win() -> void:
	gameOverPannel.show()
	game_over_lable.text="You Win!"


func day_over() -> void:
	day_complete_lable.show()
	await get_tree().create_timer(1).timeout
	day_complete_lable.hide()





func _on_button_button_down() -> void:
	SignalHub.emit_load_main()
