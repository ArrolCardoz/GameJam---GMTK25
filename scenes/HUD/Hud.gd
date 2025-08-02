extends Control

@onready var cash_label: Label = $MarginContainer/Panel/VBoxContainer/CashLabel

var _cash:int=0

func _enter_tree() -> void:
	SignalHub.get_cash.connect(update_cash)

func _ready() -> void:
	cash_label.text="%d"%_cash

func update_cash(i:int)->void:
	_cash+=i
	cash_label.text="%d"%_cash
